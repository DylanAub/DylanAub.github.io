pragma solidity ^0.4.0;
contract YouTubeVote 
{
    address owner;
    struct Person
    {
        string pseudo;
        uint age;
        string message;
        uint valuegived;
    }
    
    modifier isowner()
    {
        if(msg.sender != owner)
        {
            throw;
            _;
        }
    }
    
    function Second() public
    {
        owner = msg.sender;   
    }
    
    function kill()isowner() public
    {
        delete owner;
        selfdestruct(msg.sender);
    }
    
    
    struct Proposals
    {
        uint NbVoted;
        string Video;
    }
    Proposals[] proposals;
    
    
    
    
    
    
}







