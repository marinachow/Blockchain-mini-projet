pragma solidity ^0.8.0;

contract ProducteurContract {
    address public owner;
    mapping (address => bool) public producteurs;

    constructor() {
        owner = msg.sender;
    }

    modifier onlyOwner() {
        require(msg.sender == owner);
        _;
    }

    function ajouterProducteur(address _producteur) public onlyOwner {
        producteurs[_producteur] = true;
    }

    function enleverProducteur(address _producteur) public onlyOwner {
        producteurs[_producteur] = false;
    }

    function vendreContract(address payable _acheteur) public onlyOwner {
        require(_acheteur != address(0));
        selfdestruct(_acheteur);
    }
}
