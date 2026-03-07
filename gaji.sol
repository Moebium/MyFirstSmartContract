// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// Importing industry security standards
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/v4.9.0/contracts/access/Ownable.sol";

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/v4.9.0/contracts/security/ReentrancyGuard.sol";

contract ProBank is Ownable, ReentrancyGuard {
mapping(address => uint256) private _balances;

// Deposit function
function deposit() public payable {
require(msg.value > 0, "Send some Ether!");
_balances[msg.sender] += msg.value;
}

// Withdraw money function with reentrancy protection
function withdraw() public nonReentrant {
uint256 amount = _balances[msg.sender];
require(amount > 0, "Your balance is empty");

_balances[msg.sender] = 0; // Update the balance first (Checks-Effects)

(bool success, ) = msg.sender.call{value: amount}(""); // Then send (Interaction)
require(success, "Transfer failed");
}

// Only the bank owner can check the total bank balance
function getBankBalance() public view onlyOwner returns (uint256) {
return address(this).balance;
}
}
