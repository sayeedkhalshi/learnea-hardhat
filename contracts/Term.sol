// SPDX-License-Identifier: MIT
pragma solidity 0.8.18;

contract Term {
    address public LearneaContract; //learnea address
    address owner;
    string[] public title;
    string[] public details;
    uint256 public termType;
    address public derivedFrom;
    string[] public learningCurves;
    // timestamp of creation and update
    uint256 public createdAt;
    uint256 public lastUpdatedAt;


    address[] public perspectives_terms; //0
    address[] public co_terms; //1
    address[] public micro_terms; //childrens //2
    address[] public macro_terms; //parents //3
    address[] public philosophy_terms; //4 
    address[] public scientific_terms; //only proven scientist can add proven fact //5
 

    address[] public projects;
    
     // that solely made of two terms, address to be created for tangled term to both Term
    //mapping (address => address[]) public tangled_terms; // key - other contract. value [] adds each new tangled contract created with other one

    enum TermType {
        STANDALONE,
        PERSPECTIVE,
        CO,
        MICRO,
        MACRO,
        PHILOSOPHY,
        SCIENTIFIC
    }

    struct Details {
        string title;
        string details;
        uint256 termType;
        address derivedFrom;
    }

    struct DetailsHistory {
        string[] title;
        string[] details;
    }

    constructor(string memory _title, string memory _details, uint256 _termType, address _derivedFrom, address _learneaContract) {
    owner = msg.sender;
    title.push(_title);
    details.push(_details);
    termType = _termType;
    derivedFrom = _derivedFrom;
    LearneaContract = _learneaContract;
    createdAt = block.timestamp; // Initialize createdAt with the current block timestamp
    lastUpdatedAt = block.timestamp; // Initialize lastUpdatedAt with the current block timestamp

    addToTermType(_termType);
}

function updateTitle(string memory _title) public returns(string memory) {
    require(owner == msg.sender, "You are not the owner");
    title.push(_title);
    lastUpdatedAt = block.timestamp; // Update lastUpdatedAt
    return title[title.length - 1];
}

function updateDetails(string memory _details) public returns(string memory) {
    require(owner == msg.sender, "You are not the owner");
    details.push(_details);
    lastUpdatedAt = block.timestamp; // Update lastUpdatedAt
    return details[details.length - 1];
}


 function addToTermType(uint256 _termType) internal {
    if (_termType == uint256(TermType.STANDALONE)) {
        // Add to standalone terms array
        // Assuming you have a specific array for standalone terms
    } else if (_termType == uint256(TermType.PERSPECTIVE)) {
        perspectives_terms.push(msg.sender);
    } else if (_termType == uint256(TermType.CO)) {
        co_terms.push(msg.sender);
    } else if (_termType == uint256(TermType.MICRO)) {
        micro_terms.push(msg.sender);
    } else if (_termType == uint256(TermType.MACRO)) {
        macro_terms.push(msg.sender);
    } else if (_termType == uint256(TermType.PHILOSOPHY)) {
        philosophy_terms.push(msg.sender);
    } else if (_termType == uint256(TermType.SCIENTIFIC)) {
        scientific_terms.push(msg.sender);
    } else {
        revert("Invalid term type");
    }
}



    function addLearningCurves(string memory _curve) public returns(string[] memory){
        learningCurves.push(_curve);
        lastUpdatedAt = block.timestamp; // Update lastUpdatedAt
        return learningCurves;
    }

    function getLearningCurves()public view returns(string[] memory){
        return learningCurves;
    }

  

    function addPerspectiveTerm(address _perspective) internal  {
        perspectives_terms.push(_perspective);
    }

    function addCoterm(address _coterm) internal {
        co_terms.push(_coterm);
    }

    function addMicroterm(address _microterm) internal{
        micro_terms.push(_microterm);
    }

    function addMacroterm(address _macroterm) internal  {
        macro_terms.push(_macroterm);
    }

    function addPhilosophyTerm(address _philosophyTerm) internal {
        philosophy_terms.push(_philosophyTerm);
    }

      function addScientificTerm(address _scientificTerm) internal  {
        scientific_terms.push(_scientificTerm);
    }

    function getDetails()public view returns(Details memory) {
        uint256 lastTitleIndex = title.length - 1;
        uint256 lastDetailsIndex = details.length - 1; 
        return Details(title[lastTitleIndex], details[lastDetailsIndex], termType, derivedFrom);
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
