// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Transaction {
    struct Lot {
        uint id;
        string name;
    }
    
    struct TransactionDetails {
        uint ownerId;
        uint newOwnerId;
        uint lotId;
        uint price;
        uint date;
    }
    
    mapping(uint => Lot) public lots; // Mapping des lots de produits
    mapping(uint => TransactionDetails) public transactions; // Mapping des transactions
    
    // Fonction pour créer un lot de produits
    function createLot(uint _id, string memory _name) public {
        lots[_id] = Lot(_id, _name);
    }
    
    // Fonction pour effectuer une transaction
    function makeTransaction(uint _ownerId, uint _newOwnerId, uint _lotId, uint _price, uint _date) public {
        transactions[_date] = TransactionDetails(_ownerId, _newOwnerId, _lotId, _price, _date);
    }
}
