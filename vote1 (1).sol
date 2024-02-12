//SPDX-License-Identifier: Unlicensed
pragma solidity ^0.8.0;

contract voting{

    enum Gender{
        Female,
        Male,
        None
    }

    struct Person{
        string name;
        string surname;
        uint256 age;
        Gender gender;
    }

    address public owner;
    constructor(){
        owner = msg.sender;
    }

    modifier onlyOwner{
        require(owner == msg.sender,"You are not the owner.");
        _;
    }

    mapping (address => uint256) votesCounter;
    address[] public candidates;
    mapping (address => Person[]) voters;

    function setCandidates(address[] memory _candidates) onlyOwner external{

        candidates = _candidates;
    }

    function getVoters(address _voters, string memory _name, string memory _surname, uint256 _age, uint256 _gender) onlyOwner external{

        require(_gender == uint256 (Gender.Female) || _gender == uint256 (Gender.Male), "Invalid gender");
        Gender gender = Gender(_gender);
        Person memory newVoter = Person(_name, _surname, _age, gender);
        voters[_voters].push(newVoter);

    }

    event vote(uint256 _vote);

    function getVotes(address selectedCandidate) public{
        votesCounter[selectedCandidate]++;
        emit vote(votesCounter[selectedCandidate]);
    }

    function votes(address whichCandidate) public view returns (uint256){
        return votesCounter[whichCandidate];
    }

}

