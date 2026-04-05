pragma solidity ^0.8.0;

contract Voting {
    struct Candidate {
        string name;
        uint256 voteCount;
    }

    Candidate[] public candidates;
    mapping(address => bool) public hasVoted;

    constructor(string[] memory _names) {
        for (uint256 i = 0; i < _names.length; i++) {
            candidates.push(Candidate(_names[i], 0));
        }
    }

    function vote(uint256 _candidateIndex) public {
        require(!hasVoted[msg.sender], "you have already voted");
        require(_candidateIndex < candidates.length, "invalid candidate");

        candidates[_candidateIndex].voteCount += 1;
        hasVoted[msg.sender] = true;
    }

    function getResults() public view returns (Candidate[] memory) {
        return candidates;
    }
}