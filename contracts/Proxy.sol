pragma solidity ^0.8.0;

import "./Storage.sol";


contract Proxy{
    address implementation;
    constructor(address _implementation){
        implementation = _implementation;
    }
    function upgrade(address _implementation) public{
        implementation = _implementation;
    }

    fallback () external {

    }

    receive() external payable {
        
    }

    function _forwardCall() private {
        require(implementation != address(0));

        bytes memory data = msg.data;

        address implementationTmp = implementation;
        //this forwards the call to the Dogs contract
        assembly{
            //forward call to Dogs contract
            let result := delegatecall(gas(), implementationTmp, add(data, 0x20), mload(data), 0, 0)
            //get size of return data from forwarded call
            let size := returndatasize()
            //get a pointer from memory
            let ptr := mload(0x40)
            //copy the return data using the pointer
            returndatacopy(ptr, 0, size)
            switch result
            //if the forwarded call failed, revert the transaction
            case 0 {revert(ptr, size)}
            //if the forwardedcall succeeded, return the return data
            default {return(ptr, size)}
        }
    }

}