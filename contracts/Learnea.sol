// SPDX-License-Identifier: MIT
pragma solidity 0.8.18;

import "./Term.sol";
import "./Layer.sol";
// import "./Path.sol";

contract Learnea {
    address owner;
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

    enum TermType {
        STANDALONE,
        PERSPECTIVE,
        CO,
        MICRO,
        MACRO,
        PHILOSOPHY,
        SCIENTIFIC
    }

    struct CreatedTerm {
        uint256 id;
        address creator;
        address termAddress;
        uint256 termType;
        address derivedFrom;
    }

    struct CreatedLayer {
        uint256 id;
        address creator;
        address layerAddress;
    }

    struct CreatedPath{
        uint256 id;
        address creator;
        string title; 
        string details; 
        address startingTerm; 
        address endTerm; 
        address goalTerm;
        address pathAdress;
    }

    struct LearningPath{
        string _title; 
        string _details; 
        address _startingTerm; 
        address _endTerm; 
        address _goalTerm;
    }

    mapping (address => User) public users;
    mapping (uint256 => CreatedTerm) public terms;
    mapping (uint256 => CreatedLayer) public layers;
    mapping (address => CreatedPath) public userCreatedPathList; 
    mapping (address => LearningPath) public userPathList; //user address to how many path address it's doing. from that path address user can bring progress, 


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
    function addUserToPathList(address _pathAddress) public{
      
    }

    //TODO
    function addPathToUserPathList()public{}

    function createTerm(
        string memory _title,
        string memory _details,
        uint256  _termType,
        address _derivedFrom
    ) public {
        Term newTerm = new Term(_title, _details, _termType, _derivedFrom, address(0));
        terms[termCount] = CreatedTerm({
            id: termCount,
            creator: msg.sender,
            termAddress: address(newTerm),
            termType: _termType, //fix enum issue
            derivedFrom: _derivedFrom
        });
        termCount++;
    }

    function createLayer(
        string memory _title,
        string memory _details
    ) public {
        Layer newLayer = new Layer(_title, _details,  address(0));
        layers[layerCount] = CreatedLayer({
            id: layerCount,
            creator: msg.sender,
            layerAddress: address(newLayer)
        });
        layerCount++;
    }

    function getUser(address _userAddress) public view returns (User memory) {
        return users[_userAddress];
    }

    function getTerm(uint256 _termId) public view returns (CreatedTerm memory) {
        return terms[_termId];
    }

    function getLayer(uint256 _layerId) public view returns (CreatedLayer memory) {
        return layers[_layerId];
    }

   

    function getAllTerms() public view returns (CreatedTerm[] memory) {
        CreatedTerm[] memory allTerms = new CreatedTerm[](termCount);
        for (uint256 i = 0; i < termCount; i++) {
            allTerms[i] = terms[i];
        }
        return allTerms;
    }

    function getAllLayers() public view returns (CreatedLayer[] memory) {
        CreatedLayer[] memory allLayers = new CreatedLayer[](layerCount);
        for (uint256 i = 0; i < layerCount; i++) {
            allLayers[i] = layers[i];
        }
        return allLayers;
    }
}



    // struct Term {
    //     string title;
    //     string details;
    //     address[] perspectives;
    //     address[] coterms;
    //     address[] microterms;
    //     address[] macroterms;
    //     address[] philosophy_terms;
    // }

    // struct Layer {
    //     string title;
    //     string details;
    //     address[] terms;
    //     address creator;
    // }

   