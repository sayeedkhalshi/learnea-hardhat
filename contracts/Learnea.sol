// SPDX-License-Identifier: MIT
pragma solidity 0.7.0;


contract Learnea{
    address[] terms_address_list;
    address[] layers_address_list;

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


    constructor(){}
}


contract Term{
    //TODO in method to update make sure title is under 1000 character
    // title[title.length-1] is the current. Others are history
    string[] title; 

    //TODO in method to update make sure title is under 1000 character
    // details[details.length-1] is the current. Others are history
    string[] details;


    constructor(){

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


    constructor(){

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