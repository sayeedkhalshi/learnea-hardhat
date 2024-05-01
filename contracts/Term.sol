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


   
 

    address[] public projects;
    
     // that solely made of two terms, address to be created for tangled term to both Term
    //mapping (address => address[]) public tangled_terms; // key - other contract. value [] adds each new tangled contract created with other one


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


    function addLearningCurves(string memory _curve) public returns(string[] memory){
        learningCurves.push(_curve);
            lastUpdatedAt = block.timestamp; // Update lastUpdatedAt
        return learningCurves;
    }

    function getLearningCurves()public view returns(string[] memory){
        return learningCurves;
    }

  

 

    function getDetails()public view returns(Details memory) {
        uint256 lastTitleIndex = title.length - 1;
        uint256 lastDetailsIndex = details.length - 1; 
        return Details(title[lastTitleIndex], details[lastDetailsIndex], termType, derivedFrom);
    }

    function getDetailsHistory() public view returns(DetailsHistory memory){
        return DetailsHistory(title, details);
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
