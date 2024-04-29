// SPDX-License-Identifier: MIT
pragma solidity 0.8.18;

contract Layer {
    string public title;
    string public details;
    address[] public terms;
    address public creator;

    constructor(string memory _title, string memory _details, address _creator) {
        title = _title;
        details = _details;
        creator = _creator;
    }

    function addTerm(address _term) public {
        terms.push(_term);
    }

    function getTerms() public view returns (address[] memory) {
        return terms;
    }

    function getCreator() public view returns (address) {
        return creator;
    }
}
