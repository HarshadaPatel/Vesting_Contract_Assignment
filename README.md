# Vesting_Contract_Assignment_BlockChain



Objective
The objective of this assignment is to build a vesting contract on the blockchain with user, partner, and team roles. The contract handles token vesting according to specific schedules for each role. Solidity is used for smart contract development, and Remix IDE is used for deployment and testing.

Requirements
Smart Contract Setup
Create a Solidity smart contract to manage vesting with three roles:

User: 50% of total allocated tokens with a cliff of 10 months and a total vesting duration of 2 years.
Partner: 25% of total allocated tokens with a cliff of 2 months and a total vesting duration of 1 year.
Team: 25% of total allocated tokens with a cliff of 2 months and a total vesting duration of 1 year.
Features:

Allow the owner to start vesting.
Enable the addition of beneficiaries for each role before vesting starts.
Allow beneficiaries to claim their vested tokens according to the schedule.
Track and emit events for vesting start, beneficiary addition, and token withdrawal.
Testing (Smart Contract)
Test the creation of vesting schedules by the admin.
Verify proper token claiming by beneficiaries according to the schedule.
Ensure the correct calculation of vested tokens based on cliff and duration.
Implementation


Deployment and Testing
Deployment in Remix
Compile the Contracts:

Open ERC20Mock.sol and VestingContract.sol in Remix.
Compile both contracts.
Deploy ERC20Mock Contract:

Select ERC20Mock in the "Deploy & Run Transactions" tab.
Provide the following parameters:
name (e.g., "Test Token")
symbol (e.g., "TT")
decimals (e.g., 18)
initialSupply (e.g., 1000000)
owner (the address of the deploying account)
Click "Deploy".

Deploy VestingContract Contract:

Select VestingContract in the "Deploy & Run Transactions" tab.
Provide the deployed ERC20Mock contract address as a parameter.
Click "Deploy".
Interact with the Contracts:

Use the functions startVesting, addBeneficiary, and claimTokens from the deployed contracts to test functionality.
Testing in Remix
Start Vesting:

Call the startVesting function from the owner's account.
Add Beneficiaries:

Call the addBeneficiary function to add users, partners, and team members with appropriate token amounts.
Claim Tokens:

Use the claimTokens function from the beneficiary accounts to claim vested tokens according to the schedule.
Video Demonstration
Include a video demonstrating the deployment and interaction with the contracts using Remix.
Conclusion
This assignment demonstrates the creation and management of a vesting contract on the blockchain. The smart contract handles role-based token vesting with specific schedules, and it has been tested for proper functionality.

This README provides detailed instructions and information about the project, including the objectives, requirements, implementation details, and deployment steps.

