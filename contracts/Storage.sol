pragma solidity ^0.8.9;

contract Storage{
    //declaring mappings for different types allows you to create variables even after upgrading the functionality contract (Dogs.sol)
    mapping (string => uint) uintStorage;
    mapping (string => address) addressStorage;
    mapping (string => bool) boolStorage;
    mapping (string => string) stringStorage;
    mapping (string => bytes4) bytesStorage;

    address public owner;
    bool public _initialized;
}