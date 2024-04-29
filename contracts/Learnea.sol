// SPDX-License-Identifier: MIT
pragma solidity 0.8.18;

import "./Term.sol";
import "./Layer.sol";

contract Learnea {
    uint256 public userCount = 0;
    uint256 public termCount = 0;
    uint256 public layerCount = 0;

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
    }

    struct CreatedLayer {
        uint256 id;
        address creator;
        address layerAddress;
    }

    mapping (address => User) public users;
    mapping (uint256 => CreatedTerm) public terms;
    mapping (uint256 => CreatedLayer) public layers;

    constructor() {}

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

    function createTerm(
        string memory _title,
        string memory _details
    ) public {
        Term newTerm = new Term(_title, _details);
        terms[termCount] = CreatedTerm({
            id: termCount,
            creator: msg.sender,
            termAddress: address(newTerm)
        });
        termCount++;
    }

    function createLayer(
        string memory _title,
        string memory _details
    ) public {
        Layer newLayer = new Layer(_title, _details, msg.sender);
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

   