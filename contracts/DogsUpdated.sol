pragma solidity ^0.8.9;

import "./Storage.sol";

contract DogsUpdated is Storage {
    modifier onlyOwner{
        require(msg.sender == owner);
        _;
    }

    constructor(){
        initialize(msg.sender);
    }

    function initialize(address _owner) public{
        require(!_initialized);
        owner = _owner;
        _initialized= true;
    }
    function getNumberOfDogs() public view returns (uint){
        return uintStorage["Dogs"];
    }

    function setNumberOfDogs(uint _dogs) onlyOwner public {
        uintStorage["Dogs"] =_dogs;
    }
}