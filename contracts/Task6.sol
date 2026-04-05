pragma solidity ^0.8.0;

contract CommunityFunding {
    struct Project {
        address payable proposer;
        string description;
        uint256 requiredFunds;
        uint256 votes;
        bool funded;
    }

    Project[] public projects;
    uint256 public requiredVotesToPass = 3; 

    mapping(uint256 => mapping(address => bool)) public hasVoted;

    function depositToPool() public payable {}

    function proposeProject(string memory _description, uint256 _requiredFunds) public {
        projects.push(Project({
            proposer: payable(msg.sender),
            description: _description,
            requiredFunds: _requiredFunds,
            votes: 0,
            funded: false
        }));
    }

    function voteForProject(uint256 _projectIndex) public {
        require(_projectIndex < projects.length, "Project does not exist");
        require(!hasVoted[_projectIndex][msg.sender], "You already voted for this project");
        
        Project storage project = projects[_projectIndex];
        require(!project.funded, "Project already funded");

        project.votes += 1;
        hasVoted[_projectIndex][msg.sender] = true;

        if (project.votes >= requiredVotesToPass) {
            require(address(this).balance >= project.requiredFunds, "Not enough money in the pool");
            
            project.funded = true;
            project.proposer.transfer(project.requiredFunds);
        }
    }

    function getProjectsCount() public view returns (uint256) {
        return projects.length;
    }
}