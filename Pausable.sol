// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "./Ownable.sol";


contract Pausable is Ownable {


    bool public paused;


    event Paused();

    event Unpaused();



    modifier whenNotPaused(){

        require(
            !paused,
            "Paused"
        );

        _;
    }



    modifier whenPaused(){

        require(
            paused,
            "Not paused"
        );

        _;
    }



    function pause()
        external
        onlyOwner
        whenNotPaused
    {

        paused = true;

        emit Paused();
    }



    function unpause()
        external
        onlyOwner
        whenPaused
    {

        paused = false;

        emit Unpaused();
    }
}
