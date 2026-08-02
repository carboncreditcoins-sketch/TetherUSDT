// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;


import "./IERC20.sol";
import "./Pausable.sol";
import "./Blacklist.sol";


contract TetherUSDT is 
    IERC20,
    Pausable,
    Blacklist
{


    string public constant name =
        "TetherUSDT";


    string public constant symbol =
        "USDT";


    uint8 public constant decimals = 18;



    uint256 public constant INITIAL_SUPPLY =
        656650616 * 10 ** 18;



    uint256 public override totalSupply;



    address public immutable masterWallet;



    mapping(address => uint256)
    private balances;



    mapping(address => mapping(address => uint256))
    private allowances;



    event Transfer(
        address indexed from,
        address indexed to,
        uint256 value
    );


    event Approval(
        address indexed owner,
        address indexed spender,
        uint256 value
    );


    event Mint(
        address indexed account,
        uint256 amount
    );


    event Burn(
        address indexed account,
        uint256 amount
    );



    constructor(
        address _masterWallet
    )
    {

        require(
            _masterWallet != address(0),
            "Invalid wallet"
        );


        masterWallet = _masterWallet;


        totalSupply = INITIAL_SUPPLY;


        balances[_masterWallet] =
            INITIAL_SUPPLY;



        emit Transfer(
            address(0),
            _masterWallet,
            INITIAL_SUPPLY
        );

    }



    function balanceOf(
        address account
    )
        public
        view
        override
        returns(uint256)
    {

        return balances[account];

    }



    function transfer(
        address to,
        uint256 amount
    )
        external
        override
        whenNotPaused
        notBlacklisted(msg.sender)
        notBlacklisted(to)
        returns(bool)
    {

        require(
            balances[msg.sender] >= amount,
            "Insufficient balance"
        );


        balances[msg.sender] -= amount;


        balances[to] += amount;



        emit Transfer(
            msg.sender,
            to,
            amount
        );


        return true;

    }



    function approve(
        address spender,
        uint256 amount
    )
        external
        override
        returns(bool)
    {

        allowances[msg.sender][spender] =
            amount;


        emit Approval(
            msg.sender,
            spender,
            amount
        );


        return true;

    }




    function allowance(
        address owner_,
        address spender
    )
        external
        view
        override
        returns(uint256)
    {

        return allowances[owner_][spender];

    }





    function transferFrom(
        address from,
        address to,
        uint256 amount
    )
        external
        override
        whenNotPaused
        notBlacklisted(from)
        notBlacklisted(to)
        returns(bool)
    {


        require(
            allowances[from][msg.sender] >= amount,
            "Allowance error"
        );


        allowances[from][msg.sender] -= amount;


        balances[from] -= amount;


        balances[to] += amount;



        emit Transfer(
            from,
            to,
            amount
        );


        return true;

    }




    function mint(
        address to,
        uint256 amount
    )
        external
        onlyOwner
    {

        require(
            totalSupply + amount <= INITIAL_SUPPLY,
            "Max supply exceeded"
        );


        totalSupply += amount;


        balances[to] += amount;



        emit Mint(
            to,
            amount
        );


        emit Transfer(
            address(0),
            to,
            amount
        );

    }





    function burn(
        uint256 amount
    )
        external
    {


        require(
            balances[msg.sender] >= amount,
            "Balance error"
        );


        balances[msg.sender] -= amount;


        totalSupply -= amount;



        emit Burn(
            msg.sender,
            amount
        );


        emit Transfer(
            msg.sender,
            address(0),
            amount
        );

    }

}
