// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// Mengimpor standar keamanan industri
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/v4.9.0/contracts/access/Ownable.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/v4.9.0/contracts/security/ReentrancyGuard.sol";

contract ProBank is Ownable, ReentrancyGuard {
    mapping(address => uint256) private _balances;

    // Fungsi setor uang
    function deposit() public payable {
        require(msg.value > 0, "Kirim Ether dong!");
        _balances[msg.sender] += msg.value;
    }

    // Fungsi tarik uang dengan perlindungan Reentrancy
    function withdraw() public nonReentrant {
        uint256 amount = _balances[msg.sender];
        require(amount > 0, "Saldo kamu kosong");

        _balances[msg.sender] = 0; // Update saldo dulu (Checks-Effects)
        
        (bool success, ) = msg.sender.call{value: amount}(""); // Baru kirim (Interaction)
        require(success, "Transfer gagal");
    }

    // Hanya pemilik bank yang bisa cek total saldo bank
    function getBankBalance() public view onlyOwner returns (uint256) {
        return address(this).balance;
    }
}
