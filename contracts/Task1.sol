pragma solidity ^0.8.0;

contract Counter {
    uint256 private count;

    function increment() public {
        count += 1;
    }

    function decrement() public {
        require(count > 0, "counter must be positive");
        count -= 1;
    }

    function getCount() public view returns (uint256) {
        return count;
    }
}
