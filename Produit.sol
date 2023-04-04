// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Produit {
    uint public id;
    string public nom;

    constructor(uint _id, string memory _nom) {
        id = _id;
        nom = _nom;
    }
}
