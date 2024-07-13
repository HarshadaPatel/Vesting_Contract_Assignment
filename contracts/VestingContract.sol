// SPDX-License-Identifier: MIT
pragma solidity ^0.8.21;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/math/SafeMath.sol";

contract VestingContract is Ownable {
    using SafeMath for uint256;

    IERC20 public token;
    
    enum Role { User, Partner, Team }

    struct VestingSchedule {
        uint256 cliff;
        uint256 duration;
        uint256 start;
        uint256 totalAmount;
        uint256 releasedAmount;
    }

    mapping(address => mapping(Role => VestingSchedule)) public vestingSchedules;
    mapping(Role => uint256) public roleAllocation;

    event VestingStarted(uint256 start);
    event BeneficiaryAdded(address beneficiary, Role role, uint256 amount);
    event TokensWithdrawn(address beneficiary, uint256 amount);

    constructor(IERC20 _token, address initialOwner) Ownable(initialOwner) {
        token = _token;
        roleAllocation[Role.User] = 50; // 50% for Users
        roleAllocation[Role.Partner] = 25; // 25% for Partners
        roleAllocation[Role.Team] = 25; // 25% for Team
    }

    function startVesting() external onlyOwner {
        emit VestingStarted(block.timestamp);
    }

    function addBeneficiary(address beneficiary, Role role, uint256 totalAmount) external onlyOwner {
        require(vestingSchedules[beneficiary][role].totalAmount == 0, "Beneficiary already added for this role");
        uint256 cliff = (role == Role.User) ? 10 * 30 * 24 * 60 * 60 : 2 * 30 * 24 * 60 * 60; // 10 months or 2 months in seconds
        uint256 duration = (role == Role.User) ? 2 * 365 * 24 * 60 * 60 : 365 * 24 * 60 * 60; // 2 years or 1 year in seconds

        vestingSchedules[beneficiary][role] = VestingSchedule({
            cliff: cliff,
            duration: duration,
            start: block.timestamp,
            totalAmount: totalAmount,
            releasedAmount: 0
        });

        emit BeneficiaryAdded(beneficiary, role, totalAmount);
    }

    function claimTokens(Role role) external {
        VestingSchedule storage schedule = vestingSchedules[msg.sender][role];
        require(schedule.totalAmount > 0, "No vesting schedule for this role");

        uint256 vested = calculateVestedAmount(schedule);
        uint256 unreleased = vested.sub(schedule.releasedAmount);

        require(unreleased > 0, "No tokens to release");

        schedule.releasedAmount = schedule.releasedAmount.add(unreleased);
        token.transfer(msg.sender, unreleased);

        emit TokensWithdrawn(msg.sender, unreleased);
    }

    function calculateVestedAmount(VestingSchedule memory schedule) public view returns (uint256) {
        if (block.timestamp < schedule.start.add(schedule.cliff)) {
            return 0;
        } else if (block.timestamp >= schedule.start.add(schedule.duration)) {
            return schedule.totalAmount;
        } else {
            uint256 elapsedTime = block.timestamp.sub(schedule.start);
            uint256 vestedAmount = schedule.totalAmount.mul(elapsedTime).div(schedule.duration);
            return vestedAmount;
        }
    }
}
