pragma solidity ^0.8.0;

contract SimpleShop {
    struct Item {
        string name;
        uint256 price;
        bool isAvailable;
    }

    Item[] public items;
    address public owner;

    constructor() {
        owner = msg.sender;
    }

    function addItem(string memory _name, uint256 _price) public {
        items.push(Item(_name, _price, true));
    }

    function buyItem(uint256 _index) public payable {
        require(_index < items.length, "Item does not exist");
        Item storage item = items[_index];
        
        require(item.isAvailable, "Item unavailable");
        require(msg.value >= item.price, "incorrect payment amount");

        item.isAvailable = false;
        
        payable(owner).transfer(msg.value);
    }

    function getAllItems() public view returns (Item[] memory) {
        return items;
    }
}