// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

/** 
 * @title Lot
 * @dev Represents a batch of products of the same type
*/

contract Lot {
    struct Batch {
        uint batchId;
        address manufacturer;
        string productName;
        uint totalProducts;
        string currentOwner;
        string lastOwner;
        uint256 dateOfPurchase;
    }

    mapping (uint => Batch) batches;
    uint public nextBatchId = 1;

    function addBatch(address _manufacturer, string memory _productName, uint _totalProducts, string memory _lastOwner, uint256 _dateOfPurchase) public {
        uint batchId = nextBatchId;
        Batch memory newBatch = Batch(batchId, _manufacturer, _productName, _totalProducts, _lastOwner, _dateOfPurchase);
        batches[batchId] = newBatch;
        nextBatchId++;
    }

    function generateBatchId(string memory _currentOwner, uint256 _dateOfPurchase) public view returns (uint) {
        bytes memory ownerBytes = bytes(_currentOwner);
        bytes32 hash = keccak256(abi.encodePacked(ownerBytes, _dateOfPurchase));
        uint batchId = uint(hash);
        return batchId;
    }

    function getBatch(uint _batchId) public view returns (address, string memory, uint, string memory, uint256) {
        Batch memory batch = batches[_batchId];
        return (batch.manufacturer, batch.productName, batch.totalProducts, batch.lastOwner, batch.dateOfPurchase);
    }

    function updateBatch(uint _batchId, string memory _productName, uint _totalProducts, string memory _lastOwner, uint256 _dateOfPurchase) public {
        Batch storage batch = batches[_batchId];
        batch.productName = _productName;
        batch.totalProducts = _totalProducts;
        batch.lastOwner = _lastOwner;
        batch.dateOfPurchase = _dateOfPurchase;
    }

    function deleteBatch(uint _batchId) public {
        delete batches[_batchId];
    }
}
