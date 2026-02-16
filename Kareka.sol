// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

// Kita mengimpor standar koin dunia (ERC20)
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

// Kontrak Kareka mewarisi (inheritance) sifat ERC20 dan Ownable
contract KarekaToken is ERC20, Ownable {
    
    // Constructor dijalankan hanya 1x saat koin lahir
    constructor() ERC20("Kareka", "KRK") Ownable(msg.sender) {
        // Kita cetak 1.000.000 koin untuk pertama kali
        // 18 nol di belakang adalah standar desimal (seperti Rupiah ke Sen)
        _mint(msg.sender, 1000000 * 10 ** decimals());
    }

    // Fungsi tambahan jika kamu ingin mencetak koin lagi di masa depan
    function mintLagi(address ke, uint256 jumlah) public onlyOwner {
        _mint(ke, jumlah);
    }
}