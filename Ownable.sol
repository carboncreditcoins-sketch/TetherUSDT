// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract Ownable {

    address public owner;

    event OwnershipTransferred(
        address indexed previousOwner,
        address indexed newOwner
    );


    constructor(){

        owner = msg.sender;

        emit OwnershipTransferred(
            address(0),
            owner
        );
    }


    modifier onlyOwner(){

        require(
            msg.sender == owner,
            "Not owner"
        );

        _;
    }


    function transferOwnership(
        address newOwner
    )
        external
        onlyOwner
    {

        require(
            newOwner != address(0),
            "Invalid owner"
        );

        emit OwnershipTransferred(
            owner,
            newOwner
        );

        owner = newOwner;
    }
}
