// SPDX-License-Identifier: MIT
pragma solidity 0.8.18;


//Project is about doing something
//Project will have goals, teams(with extra title), details, founder, co founder
contract Path{
    address public LearneaContract; //learnea address
    address public owner; //msg.sender deployer
    mapping(address => string) public mods;
    string[] public title;
    string[] public details;
    address[] public startingTerm;
    address[] public endTerm;
    address public goalTerm;
    address[] public pathTerms; //address of terms from start to finish

    mapping (address => address[]) public learnersProgress;


    struct Details {
        string title;
        string details;
        address owner;
        address startingTerm;
        address endTerm;
        address goalTerm;
        address[] terms;
    }

    struct DetailsHistory {
        string[] title;
        string[] details;
        address[] startingTerm;
        address[] endTerm;
    }

    constructor(string memory _title, string memory _details, address _startingTerm, address _endTerm, address _goalTerm,  address _learneaContract){
        owner = msg.sender;
        title.push(_title);
        details.push(_details);
        startingTerm.push(_startingTerm);
        endTerm.push(_endTerm);
        goalTerm = _goalTerm;
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


    function getDetails()public view returns(Details memory) {
        uint256 lastTitleIndex = title.length - 1;
        uint256 lastDetailsIndex = details.length - 1; 
        uint256 lastStartingTermIndex = startingTerm.length - 1; 
        uint256 lastEndTermIndex = endTerm.length -1;
        return Details(title[lastTitleIndex], details[lastDetailsIndex], owner, startingTerm[lastStartingTermIndex], endTerm[lastEndTermIndex], goalTerm, pathTerms);
    }

    function getDetailsHistory() public view returns(DetailsHistory memory){
        return DetailsHistory(title, details, startingTerm, endTerm);
    }

    //ToDo
    function addMod(address _mod) public {
        require( owner == msg.sender, "You are not the owner");

        //ToDo - check if mod already exist
        //ToDo if doesn't exist add the mod
        mods[_mod] = "mod";
    }

    //ToDo
    function removeMod(address _mod) public {
        require( owner == msg.sender, "You are not the owner");
            delete mods[_mod];
    }

    //ToDo
    function updateStartingTerm(address _address) public{
        //Only if mod or owner
        //TODO
        startingTerm.push(_address);
    }


    
    
    function addTermsPathTerms( address[] memory _address )public{
        //TODO require owner or Mod
        

        //check not greater than 90
        require(_address.length <= 90, "Index length must be not greater than 90");

        for(uint8 i = 0; i < _address.length; i++){

            //ToDo need to check if the tern exist in Learnea contract. Need to check each contract before add to any list
            //TODO check if address already exist in pathTerms
            pathTerms.push(_address[i]);

        }

    }

    function addSingleTermToPath(address _address) public{
        //TODO require owner or Mod
        //ToDo need to check if the tern exist in Learnea contract. Need to check each contract before add to any list
        //TODO check if address already exist in pathTerms
         pathTerms.push(_address);

    }

    //TODO
    function checkIfAddressIsInPath(address _address)public{
        //if it has to be a for loop then change the data structure and change all the methods and data accordingly
    }
}