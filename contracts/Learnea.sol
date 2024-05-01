// SPDX-License-Identifier: MIT
pragma solidity 0.8.18;

import "./Term.sol";
//import "./Layer.sol";

contract Learnea {
    address owner;
    address[] public standaloneTerms;
    uint256 public userCount = 0;
    uint256 public termCount = 0;
    uint256 public layerCount = 0;
    uint256 public pathCount = 0;

    struct User {
        uint256 id;
        address wallet;
        string name;
        string title;
        string details;
        
    }


    struct CreatedTerm {
        uint256 id;
        address creator;
        address termAddress;
        uint256 termType;
        address derivedFrom;
        address[] perspectives_terms; //1
        address[] co_terms; //2
        address[] micro_terms; //childrens //3
        address[] macro_terms; //parents //4
        address[] philosophy_terms; //5 
        address[] scientific_terms; //only proven scientist can add proven fact //6

    }

    struct CreatedLayer {
        uint256 id;
        address creator;
        address layerAddress;
    }

    // struct CreatedPath{
    //     uint256 id;
    //     address creator;
    //     string title; 
    //     string details; 
    //     address startingTerm; 
    //     address endTerm; 
    //     address goalTerm;
    //     address pathAdress;
    // }

    // struct LearningPath{
    //     string _title; 
    //     string _details; 
    //     address _startingTerm; 
    //     address _endTerm; 
    //     address _goalTerm;
    // }


    enum TermType {
        STANDALONE,
        PERSPECTIVE,
        CO,
        MICRO,
        MACRO,
        PHILOSOPHY,
        SCIENTIFIC
    }

    mapping (address => User) public users;
    mapping (address => CreatedTerm) public terms;
    mapping (address => CreatedLayer) public layers;
    //mapping (address => CreatedPath) public userCreatedPathList; 
    //mapping (address => LearningPath) public userPathList; //user address to how many path address it's doing. from that path address user can bring progress, 


    constructor() {
        owner=msg.sender;
    }

    


    function createUser(
        string memory _name,
        string memory _title,
        string memory _details
    ) public {
        require(users[msg.sender].wallet == address(0), "User already exists");

        User memory newUser = User({
            id: userCount,
            wallet: msg.sender,
            name: _name,
            title: _title,
            details: _details
        });

        users[msg.sender] = newUser;
        userCount++;
    }



    //TODO Create path contract
    //   function createPath(
    //     string memory _title, 
    //     string memory _details, 
    //     address _startingTerm,
    //      address _endTerm, 
    //      address _goalTerm 
    // ) public {
    //     Path newPath = new Path(_title, _details, _startingTerm, _endTerm, _goalTerm, address(0));

    //     userCreatedPathList[msg.sender] = CreatedPath({
    //     id: pathCount,
    //     creator: msg.sender,
    //     title: _title, 
    //     details: _details, 
    //     startingTerm: _startingTerm, 
    //     endTerm: _endTerm, 
    //     goalTerm: _goalTerm,
    //     pathAdress: address(newPath)
    //     });
    //     pathCount++;
    // }

    // and add it to users list
    // function addUserToPathList(address _pathAddress) public{
      
    // }

    //TODO
    // function addPathToUserPathList()public{}

    function createTerm(
        string memory _title,
        string memory _details,
        uint256  _termType,
        address _derivedFrom
    ) public returns(address){
      
        Term newTerm = new Term(_title, _details, _termType, _derivedFrom, address(this));
        terms[address(newTerm)] = CreatedTerm({
            id: termCount,
            creator: msg.sender,
            termAddress: address(newTerm),
            termType: _termType, //fix enum issue
            derivedFrom: _derivedFrom,
            perspectives_terms: new address[](0),
        co_terms: new address[](0),
        micro_terms: new address[](0),
        macro_terms: new address[](0),
        philosophy_terms: new address[](0),
        scientific_terms: new address[](0)
        });

        // Directly modify the CreatedTerm struct associated with the derivedFrom address
        if(_termType == uint256(TermType.STANDALONE)){
            standaloneTerms.push(address(newTerm));
        }
        else if (_termType == uint256(TermType.PERSPECTIVE)) {
            terms[_derivedFrom].perspectives_terms.push(address(newTerm));
        } else if (_termType == uint256(TermType.CO)) {
            terms[_derivedFrom].co_terms.push(address(newTerm));
        } else if (_termType == uint256(TermType.MICRO)) {
            terms[_derivedFrom].micro_terms.push(address(newTerm));
        } else if (_termType == uint256(TermType.MACRO)) {
            terms[_derivedFrom].macro_terms.push(address(newTerm));
        } else if (_termType == uint256(TermType.PHILOSOPHY)) {
            terms[_derivedFrom].philosophy_terms.push(address(newTerm));
        } else if (_termType == uint256(TermType.SCIENTIFIC)) {
            terms[_derivedFrom].scientific_terms.push(address(newTerm));
        }
        

      

        termCount++;

        return address(newTerm);
    }

    // function createLayer(
    //     string memory _title,
    //     string memory _details
    // ) public {
    //     Layer newLayer = new Layer(_title, _details,  address(0));
    //     layers[layerCount] = CreatedLayer({
    //         id: layerCount,
    //         creator: msg.sender,
    //         layerAddress: address(newLayer)
    //     });
    //     layerCount++;
    // }

    function getUser(address _userAddress) public view returns (User memory) {
        return users[_userAddress];
    }

    function getTerm(address _address) public view returns (CreatedTerm memory) {
        return terms[_address];
    }

    function getStandaloneTerms() public view returns (address[] memory) {
        return standaloneTerms;
    }

    function getLastPerspectivesTerms(address _address, uint256 _lastIndex) public view returns(address ){
    // Check if there are any terms to return, to avoid accessing an empty array
        return terms[_address].perspectives_terms[terms[_address].perspectives_terms.length - _lastIndex];
    }

    function getLastCoTerm(address _address, uint256 _lastIndex) public view returns(address){
        return terms[_address].co_terms[terms[_address].co_terms.length - _lastIndex];
    }

    function getLastMicroTerm(address _address, uint256 _lastIndex) public view returns(address){
        return terms[_address].micro_terms[terms[_address].micro_terms.length - _lastIndex];
    }

    function getLastMacroTerm(address _address, uint256 _lastIndex) public view returns(address){
        return terms[_address].macro_terms[terms[_address].macro_terms.length - _lastIndex];
    }

    function getLastPhilosophyTerm(address _address, uint256 _lastIndex) public view returns(address){
        return terms[_address].philosophy_terms[terms[_address].philosophy_terms.length - _lastIndex];
    }
    function getLastScientificTerms(address _address, uint256 _lastIndex) public view returns(address){
        return  terms[_address].scientific_terms[terms[_address].scientific_terms.length - _lastIndex];
    }
    
    

}
    