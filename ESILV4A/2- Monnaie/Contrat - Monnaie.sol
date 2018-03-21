pragma solidity ^0.4.0;

interface ERC20 {
    function totalSupply() constant returns (uint256);
    function balanceOf(address _owner) constant returns (uint256 balance);
    function transfer(address _to, uint256 _value) returns (bool success);
    function transferFrom(address _from, address _to, uint256 _value) returns (bool success);
    function approve(address _spender, uint256 _value) returns (bool success);
    function allowance(address _owner, address _spender) constant returns (uint256 remaining);
    event Transfer(address indexed _from, address indexed _to, uint256 _value);
    event Approval(address indexed _owner, address indexed _spender, uint256 _value);
    }


contract DylanCoin is ERC20 {
    uint public constant _totalSupply = 100000000000;
    string public constant symbol = "MADA";
    string public constant name = "DylanCoin";
    uint8 public constant decimals = 0;
    mapping(address => uint256) balances;
    mapping(address => mapping(address => uint256)) allowed;
    
    address owner;
    
    function DylanToken() private
        { balances[msg.sender] = _totalSupply; }
    
    function totalSupply() public constant returns (uint256)
        { return _totalSupply; }
    
    function balanceOf(address _owner) public constant returns (uint256 balance)
        { return balances[_owner]; }
    
    function transfer(address _to, uint256 _value) public returns (bool success)
    {
        require(balances[msg.sender] >= _value && _value > 0);
        balances[msg.sender] -= _value; balances[_to] += _value;
        Transfer(msg.sender, _to, _value);
        return true;
    }
    
    function transferFrom(address _from, address _to, uint256 _value) public returns (bool success)
    {
        require(allowed[_from][msg.sender] >= _value && balances[_from] >= _value && _value > 0);
        balances[_from] -= _value;
        balances[_to] += _value;
        allowed[_from][msg.sender] -= _value;
        Transfer(_from, _to, _value);
        return true;
    }
    
    function approve(address _spender, uint256 _value) public returns (bool success)
    {
        allowed[msg.sender][_spender] = _value;
        Approval(msg.sender, _spender, _value);
        return true;
    }
    
    function allowance(address _owner, address _spender) public constant returns (uint256 remaining)
    {
        return allowed[_owner][_spender];
    }
    
    event Transfer(address indexed _from, address indexed _to, uint256 _value);
    event Approval(address indexed _owner, address indexed _spender, uint256 _value);
    
    modifier isowner()
    {
        if(msg.sender != owner)
        {
            throw;
        }
        _;
    }
    
    function kill()isowner() public
    {
        delete owner;
        selfdestruct(msg.sender);
    }
}



