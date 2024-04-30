// SPDX-License-Identifier: MIT
pragma solidity 0.8.18;

contract Term {
    address public LearneaContract; //learnea address
    address owner;
    string[] public title;
    string[] public details;
    uint256 public termType;
    address public deriivedFrom;
    //TODO timestamp of creation and update

    address[] public perspectives_terms; //0
    address[] public co_terms; //1
    address[] public micro_terms; //childrens //2
    address[] public macro_terms; //parents //3
    address[] public philosophy_terms; //4 
    address[] public scientific_terms; //only proven scientist can add proven fact //5
 

    address[] public projects;
    
     // that solely made of two terms, address to be created for tangled term to both Term
    //mapping (address => address[]) public tangled_terms; // key - other contract. value [] adds each new tangled contract created with other one

   

    struct Details {
        string title;
        string details;
        uint256 termType;
        address deriivedFrom;
    }

    struct DetailsHistory {
        string[] title;
        string[] details;
    }

    constructor(string memory _title, string memory _details, uint256 _termType, address _derivedFrom,  address _learneaContract) {
        owner = msg.sender;
        title.push(_title);
        details.push(_details);
        termType = _termType;
        deriivedFrom = _derivedFrom;
        LearneaContract = _learneaContract;
    }

    function updateTitle(string memory _title) public {
        require( owner == msg.sender, "You are not the owner");
        title.push(_title);

    }

    function updateDetails(string memory _details) public {
        require( owner == msg.sender, "You are not the owner");
        details.push(_details);

    }

    function addPerspective(address _perspective) public {
        perspectives_terms.push(_perspective);
    }

    function addCoterm(address _coterm) public {
        co_terms.push(_coterm);
    }

    function addMicroterm(address _microterm) public {
        micro_terms.push(_microterm);
    }

    function addMacroterm(address _macroterm) public {
        macro_terms.push(_macroterm);
    }

    function addPhilosophyTerm(address _philosophyTerm) public {
        philosophy_terms.push(_philosophyTerm);
    }

      function addScientificTerm(address _scientificTerm) public {
        scientific_terms.push(_scientificTerm);
    }

    function getDetails()public view returns(Details memory) {
        uint256 lastTitleIndex = title.length - 1;
        uint256 lastDetailsIndex = details.length - 1; 
        return Details(title[lastTitleIndex], details[lastDetailsIndex], termType, deriivedFrom);
    }

    function getDetailsHistory() public view returns(DetailsHistory memory){
        return DetailsHistory(title, details);
    }

    function getPerspectives() public view returns (address[] memory) {
        return perspectives_terms;
    }

    function getCo_terms() public view returns (address[] memory) {
        return co_terms;
    }

    function getMicro_terms() public view returns (address[] memory) {
        return micro_terms;
    }

    function getMacro_terms() public view returns (address[] memory) {
        return macro_terms;
    }

    function getPhilosophyTerms() public view returns (address[] memory) {
        return philosophy_terms;
    }

    function getScientificTerms() public view returns (address[] memory) {
        return scientific_terms;
    }

    //get tangledterms by address and get all tangled terms
    // function getAllTangledTerms() public view returns() {
    //     return tangled_terms;
    // }

    // //by address of other term
    // function getAllTangledTermsByAddress() public view returns() {
    //     return tangled_terms;
    // }
}
