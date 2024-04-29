// SPDX-License-Identifier: MIT
pragma solidity 0.7.0;


contract Learnea{
    // address[] terms_address_list;
    // address[] layers_address_list;

    //micro layers
    //macro layers


    struct User{
        uint256 id;
        address wallet;
        string name;
        string title;
        string details;
        address[] terms; //new contract address
        address[] layers;
        
        // term and layers will be seperate
    }

    mapping ( address => User ) public users;

    enum TermsType {
        STANDALONE
    }

    //terms type
    //1. if no terms attached anywhere, it's standalone
    //2. 
    struct Term {
        string title;
        string details;
        uint256[] terms_around; // id / contract address of terms
        uint256[] perspectives; //id / contract address - explaining from different perspective
        address[] coterms; //terms that are not up or down but related
        address[] microterms; //terms that can be studied under a terms
        address[] macroterms; //a term can be studied under many terms, those are macro
        mapping (address => address) tangledterms; // first address is the new tangled term, second address is the term that tangled with this one.
        address[] philosophy_terms;
    }

    mapping ( address => Term ) public terms; // term address is the key

    struct Layer {
        string title;
        string details;
        uint256[] terms; // id / contract address of terms
        address creator; 
    }

    mapping ( address => Layer ) public layers; // layer address is the key



    constructor(){}

    //methods
    //create user by verifying a signed message
      function createUser(
        string memory _name,
        string memory _title,
        string memory _details
    ) public {
        // Verify the signer
        require(users[msg.sender].wallet == address(0), "User already exists");

        // Create a new user
        User memory newUser = User({
            id: userCount,
            wallet: msg.sender,
            name: _name,
            title: _title,
            details: _details,
            terms: new address[](0),
            layers: new address[](0)
        });

        // Add the new user to the mapping
        users[msg.sender] = newUser;

        // Increment the user count
        userCount++;
    }

    // Method to create a term
    function createTerm(
        string memory _title,
        string memory _details
    ) public {
        require(bytes(_title).length <= 1000, "Title must be under 1000 characters");
        require(bytes(_details).length <= 1000, "Details must be under 1000 characters");

        Term memory newTerm = Term({
            title: _title,
            details: _details,
            termsAround: new address[](0),
            perspectives: new address[](0),
            coterms: new address[](0),
            microterms: new address[](0),
            macroterms: new address[](0),
            tangledTerms: new mapping(address => address),
            philosophyTerms: new address[](0)
        });

        // Deploy a new Term contract instance and set the owner to msg.sender
        // Note: This requires the Term contract to be deployed from the Learnea contract
        // For simplicity, we're directly adding the term to the mapping here
        terms[msg.sender] = newTerm;
    }

    // Method to create a layer
    function createLayer(
        string memory _title,
        string memory _details
    ) public {
        require(bytes(_title).length <= 1000, "Title must be under 1000 characters");
        require(bytes(_details).length <= 1000, "Details must be under 1000 characters");

        Layer memory newLayer = Layer({
            title: _title,
            details: _details,
            terms: new address[](0),
            creator: msg.sender
        });

        // Similar to the Term creation, we're directly adding the layer to the mapping here
        layers[msg.sender] = newLayer;
    }

     function getUserTerms(address _userAddress) public view returns (address[] memory) {
        return users[_userAddress].terms;
    }

    function getUserLayers(address _userAddress) public view returns (address[] memory) {
        return users[_userAddress].layers;
    }
}


contract Term{
    //TODO in method to update make sure title is under 1000 character
    // title[title.length-1] is the current. Others are history
    string[] title; 

    //TODO in method to update make sure title is under 1000 character
    // details[details.length-1] is the current. Others are history
    string[] details;
    address[] public termsAround; // Addresses of terms around
    address[] public perspectives; // Addresses of perspectives
    address[] public coterms; // Addresses of coterms
    address[] public microterms; // Addresses of microterms
    address[] public macroterms; // Addresses of macroterms
    mapping (address => address) public tangledTerms; // Mapping of tangled terms
    address[] public philosophyTerms; // Addresses of philosophy terms

    constructor(address _owner, string memory _title, string memory _details) {
        owner = _owner;
        title = _title;
        details = _details;
    }

    function updateTitle(string memory _newTitle) public {
        require(msg.sender == owner, "Only the owner can update the title");
        title = _newTitle;
    }

    function updateDetails(string memory _newDetails) public {
        require(msg.sender == owner, "Only the owner can update the details");
        details = _newDetails;
    }

    function addTermAround(address _termAddress) public {
        termsAround.push(_termAddress);
    }

    function addPerspective(address _perspectiveAddress) public {
        perspectives.push(_perspectiveAddress);
    }

    function addCoterm(address _cotermAddress) public {
        coterms.push(_cotermAddress);
    }

    function addMicroterm(address _microtermAddress) public {
        microterms.push(_microtermAddress);
    }

    function addMacroterm(address _macrotermAddress) public {
        macroterms.push(_macrotermAddress);
    }

    function addTangledTerm(address _tangledTermAddress) public {
        tangledTerms[_tangledTermAddress] = address(0); // Placeholder for the tangled term's address
    }

    function addPhilosophyTerm(address _philosophyTermAddress) public {
        philosophyTerms.push(_philosophyTermAddress);
    }

}

contract Layer {
    // Some terms can be chosen under a layer. All microterms under it will be in that layer.

        //TODO in method to update make sure title is under 1000 character
    // title[title.length-1] is the current. Others are history
    string[] title; 

    //TODO in method to update make sure title is under 1000 character
    // details[details.length-1] is the current. Others are history
    string[] details;

    address public owner;
    address[] public terms; // Terms that belong to this layer

    constructor() {
        owner = msg.sender;
    }

    function updateTitle(string memory _newTitle) public {
        require(msg.sender == owner, "Only the owner can update the title");
        require(bytes(_newTitle).length <= 1000, "Title must be under 1000 characters");
        title.push(_newTitle);
    }

    function updateDetails(string memory _newDetails) public {
        require(msg.sender == owner, "Only the owner can update the details");
        require(bytes(_newDetails).length <= 1000, "Details must be under 1000 characters");
        details.push(_newDetails);
    }

    function addTerm(address _termAddress) public {
        terms.push(_termAddress);
    }
}

//Learning thread. Each thread is a learning process. Threads can be anything that takes a thread on your brain
//There is only a few thread our brain can take all the time. 
//Thread is personal
contract Thread{
    address owner;

}

//Threads and projects both will have activity and activity management will be designed here
contract activity{

}

//Project is about doing something
//Project will have goals, teams(with extra title), details, founder, co founder
contract Project{
    
}`