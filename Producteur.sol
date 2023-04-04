// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Producteurs {
    address public owner; // Adresse du propriétaire du lot
    uint public price; // Prix du lot
    bool public isForSale; // Booléen indiquant si le lot est en vente
    mapping(uint => bool) public products; // Mapping des produits enregistrés dans le lot

    constructor(uint _price) {
        owner = msg.sender; // Initialise l'adresse du propriétaire avec l'adresse du créateur du contrat
        price = _price; // Initialise le prix du lot
    }

    // Fonction pour ajouter un produit dans le lot en utilisant son identifiant
    function addProduct(uint productId) public {
        require(msg.sender == owner, "Seul le proprietaire peut ajouter des produits au lot"); // Vérifie que l'appelant est le propriétaire
        products[productId] = true; // Ajoute le produit dans le mapping
    }

    // Fonction pour vendre le lot
    function sell() public {
        require(msg.sender == owner, "Seul le proprietaire peut vendre le lot"); // Vérifie que l'appelant est le propriétaire
        isForSale = true; // Indique que le lot est en vente
    }

    // Fonction pour acheter le lot
    function buy() public payable {
        require(isForSale, "Le lot n'est pas en vente"); // Vérifie que le lot est en vente
        require(msg.value == price, "Le montant envoye ne correspond pas au prix du lot"); // Vérifie que le montant envoyé correspond au prix du lot
        payable(owner).transfer(msg.value); // Transfère les fonds à l'adresse du propriétaire
        //owner.transfer(msg.value); // Transfère les fonds à l'adresse du propriétaire
        owner = msg.sender; // Transfère la propriété du lot à l'acheteur
        isForSale = false; // Indique que le lot n'est plus en vente
    }
}
