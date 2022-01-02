pragma solidity ^0.8.9;

import "./Storage.sol";

contract Dogs is Storage {
    modifier onlyOwner{
        require(msg.sender == owner);
        _;
    }

    constructor(){
        owner = msg.sender;
    }

    function getNumberOfDogs() public view returns (uint){
        return uintStorage["Dogs"];
    }

    function setNumberOfDogs(uint _dogs) public {
        uintStorage["Dogs"] =_dogs;
    }
}