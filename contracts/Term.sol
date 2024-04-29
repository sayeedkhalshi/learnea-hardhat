// SPDX-License-Identifier: MIT
pragma solidity 0.8.18;

contract Term {
    string public title;
    string public details;
    address[] public perspectives;
    address[] public coterms;
    address[] public microterms;
    address[] public macroterms;
    address[] public philosophyTerms;

    constructor(string memory _title, string memory _details) {
        title = _title;
        details = _details;
    }

    function addPerspective(address _perspective) public {
        perspectives.push(_perspective);
    }

    function addCoterm(address _coterm) public {
        coterms.push(_coterm);
    }

    function addMicroterm(address _microterm) public {
        microterms.push(_microterm);
    }

    function addMacroterm(address _macroterm) public {
        macroterms.push(_macroterm);
    }

    function addPhilosophyTerm(address _philosophyTerm) public {
        philosophyTerms.push(_philosophyTerm);
    }

    function getPerspectives() public view returns (address[] memory) {
        return perspectives;
    }

    function getCoterms() public view returns (address[] memory) {
        return coterms;
    }

    function getMicroterms() public view returns (address[] memory) {
        return microterms;
    }

    function getMacroterms() public view returns (address[] memory) {
        return macroterms;
    }

    function getPhilosophyTerms() public view returns (address[] memory) {
        return philosophyTerms;
    }
}
