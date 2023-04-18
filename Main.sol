// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Main {
    struct Manufacturer {
        uint producteurId;
        string producteurName;
    }
    struct Product {
        uint productId;
        string productName;
    }
    struct Batch {
        uint batchId;
        uint producteurId;
        uint totalProducts;
        uint dateOfPurchase;
    }
    struct TransactionDetails {
        uint ownerId;
        uint newOwnerId;
        uint lotId;
        uint date;
    }

    mapping (uint => Manufacturer) manufacturers;
    mapping (uint => Product) products;
    mapping (uint => Batch) batches;
    mapping (uint => TransactionDetails) transactions;
    uint public lastTransactionId = 0;


    function addProducteur(uint _producteurId, string memory _producteurName) public {
        Manufacturer memory newManufacturer = Manufacturer(_producteurId, _producteurName);
        manufacturers[_producteurId] = newManufacturer;    
    }

    function addProduit(uint _productId, string memory _productName) public {
        Product memory newProduct =  Product(_productId, _productName);
        products[_productId] = newProduct;
    }

    function addBatch(uint _batchId, uint _producteurId, uint _totalProducts, uint _dateOfPurchase) public {
        Batch memory newBatch = Batch(_batchId, _producteurId, _totalProducts, _dateOfPurchase);
        batches[_batchId] = newBatch;    
    }

    function getBatch(uint _batchId) public view returns (uint producteurId, uint totalProducts, uint256 dateOfPurchase) {
        Batch memory batch = batches[_batchId];
        return (batch.producteurId, batch.totalProducts, batch.dateOfPurchase);
    }

    function getTransaction(uint _transactionId) public view returns (uint, uint, uint, uint) {
        TransactionDetails memory transactionDetails = transactions[_transactionId];
        return (transactionDetails.ownerId, transactionDetails.newOwnerId, transactionDetails.lotId, transactionDetails.date);
    }

    function makeTransaction(uint _ownerId, uint _newOwnerId, uint _lotId, uint _date) public {
        Batch storage lot = batches[_lotId];
        require(lot.producteurId == _ownerId, "L'ancien proprietaire n'est pas correct"); // Vérifie que l'ancien propriétaire est correct
        lot.producteurId = _newOwnerId; // Change le propriétaire du lot
        transactions[_date] = TransactionDetails(_ownerId, _newOwnerId, _lotId, _date);
        lastTransactionId++; // Incrémente l'id de transaction
        transactions[lastTransactionId] = TransactionDetails(_ownerId, _newOwnerId, _lotId, _date);
    }
}
