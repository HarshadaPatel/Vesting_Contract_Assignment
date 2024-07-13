// SPDX-License-Identifier: MIT
pragma solidity ^0.8.21;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

/// @title MyContract - A simple example contract
/// @notice This contract does nothing special
// @custom:dev-run-script deploy_with_web3.js

contract ERC20Mock is ERC20, Ownable {
    constructor(
        string memory name,
        string memory symbol,
        uint8 decimals,
        uint256 initialSupply,
        address owner
    ) ERC20(name, symbol) Ownable (owner) {
        _mint(msg.sender, initialSupply * 10 ** uint256(decimals));
    }

    function mint(address to, uint256 amount) external onlyOwner {
        _mint(to, amount);
    }

    function burn(address from, uint256 amount) external onlyOwner {
        _burn(from, amount);
    }
}//"0x5B38Da6a701c568545dCfcB03FcB875f56beddC4"
