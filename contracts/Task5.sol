pragma solidity ^0.8.0;

contract SubscriptionSystem {
    address public admin;
    uint256 public subscriptionPrice;
    uint256 public duration = 30 days; 

    mapping(address => uint256) public subscriptionExpiresAt;

    constructor(uint256 _initialPrice) {
        admin = msg.sender;
        subscriptionPrice = _initialPrice;
    }

    modifier onlyAdmin() {
        require(msg.sender == admin, "permission denied");
        _;
    }

    function buySubscription() public payable {
        require(msg.value == subscriptionPrice, "incorrect payment amount");
        
        if (subscriptionExpiresAt[msg.sender] < block.timestamp) {
            subscriptionExpiresAt[msg.sender] = block.timestamp + duration;
        } else {
            subscriptionExpiresAt[msg.sender] += duration;
        }
    }

    function isSubscriptionActive(address _user) public view returns (bool) {
        return subscriptionExpiresAt[_user] > block.timestamp;
    }

    function updatePrice(uint256 _newPrice) public onlyAdmin {
        subscriptionPrice = _newPrice;
    }

    function withdraw() public onlyAdmin {
        payable(admin).transfer(address(this).balance);
    }
}