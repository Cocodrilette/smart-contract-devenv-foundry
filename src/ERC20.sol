// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

contract ERC20 {
    string private _name;
    string private _symbol;
    uint8 private _decimals;

    uint256 private _totalSupply;
    mapping(address => uint256) private _balances;
    mapping(address => mapping(address => uint256)) private _allowances;

    event Transfer(address indexed _from, address indexed _to, uint256 _value);
    event Approval(
        address indexed _owner,
        address indexed _spender,
        uint256 _value
    );

    error InsufficientBalance();
    error InsufficientAllowance();

    constructor(
        string memory __name,
        string memory __symbol,
        uint8 __decimals
    ) {
        _name = __name;
        _symbol = __symbol;
        _decimals = __decimals;
    }

    function name() public view returns (string memory) {
        return _name;
    }

    function symbol() public view returns (string memory) {
        return _symbol;
    }

    function decimals() public view returns (uint8) {
        return _decimals;
    }

    function totalSupply() public view returns (uint256) {
        return _totalSupply;
    }

    function balanceOf(address _owner) public view returns (uint256 balance) {
        balance = _balances[_owner];
    }

    function mint(address _to, uint256 _value) public returns (bool success) {
        _totalSupply += _value;
        _balances[_to] += _value;

        emit Transfer(address(0), _to, _value);

        return true;
    }

    function burn(uint256 _value) public returns (bool success) {
        uint256 balance = balanceOf(msg.sender);
        if (balance < _value) {
            revert InsufficientBalance();
        }

        _totalSupply -= _value;
        _balances[msg.sender] -= _value;

        emit Transfer(msg.sender, address(0), _value);

        return true;
    }

    function transfer(
        address _to,
        uint256 _value
    ) public returns (bool success) {
        uint256 balance = balanceOf(msg.sender);
        if (balance < _value) {
            revert InsufficientBalance();
        }

        _balances[msg.sender] -= _value;
        _balances[_to] += _value;

        emit Transfer(msg.sender, _to, _value);

        return true;
    }

    function transferFrom(
        address _from,
        address _to,
        uint256 _value
    ) public returns (bool success) {
        uint256 balance = balanceOf(_from);
        if (balance < _value) {
            revert InsufficientBalance();
        }

        uint256 _allowance = _allowances[_from][msg.sender];
        if (_allowance < _value) {
            revert InsufficientAllowance();
        }

        _allowances[_from][msg.sender] -= _value;
        _balances[_from] -= _value;
        _balances[_to] += _value;

        emit Transfer(_from, _to, _value);

        return true;
    }

    function approve(
        address _spender,
        uint256 _value
    ) public returns (bool success) {
        _allowances[msg.sender][_spender] = _value;

        emit Approval(msg.sender, _spender, _value);

        return true;
    }

    /**
     * @notice Returns the amount which _spender is still allowed to withdraw from _owner.
     */
    function allowance(
        address _owner,
        address _spender
    ) public view returns (uint256 remaining) {
        return _allowances[_owner][_spender];
    }
}

// cast call 0x9d1c5469053616CE35CBCE2829e13615E708B417 "balanceOf(address)(uint256)" 0x3Bd208F4bC181439b0a6aF00C414110b5F9d2656 --rpc-url https://rpc.ankr.com/avalanche_fuji