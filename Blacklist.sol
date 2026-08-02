// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;


import "./Ownable.sol";


contract Blacklist is Ownable {


    mapping(address => bool)
    public isBlacklisted;



    event AddedBlacklist(
        address indexed account
    );


    event RemovedBlacklist(
        address indexed account
    );



    modifier notBlacklisted(
        address account
    ){

        require(
            !isBlacklisted[account],
            "Blacklisted"
        );

        _;
    }



    function addBlacklist(
        address account
    )
        external
        onlyOwner
    {

        isBlacklisted[account] = true;

        emit AddedBlacklist(account);
    }



    function removeBlacklist(
        address account
    )
        external
        onlyOwner
    {

        isBlacklisted[account] = false;

        emit RemovedBlacklist(account);
    }

}
