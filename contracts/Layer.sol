// SPDX-License-Identifier: MIT
pragma solidity 0.8.18;

contract Layer {
    address public LearneaContract; //learnea address
    string public title;
    string public details;
    address[] public terms;
    address public owner;

    constructor(string memory _title, string memory _details, address _learneaContract) {
        title = _title;
        details = _details;
        owner = msg.sender;
        LearneaContract = _learneaContract;
    }

    function addTerm(address _term) public {
        terms.push(_term);
    }

    function getTerms() public view returns (address[] memory) {
        return terms;
    }

    function getCreator() public view returns (address) {
        return owner;
    }
}
