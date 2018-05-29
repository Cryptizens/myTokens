pragma solidity ^0.4.19;

import './SafeMath.sol';

contract ERC20 {
  using SafeMath for uint256;

  uint256 public totalSupply;
  uint256 public decimals = 18;
  string public name = "My ERC20 token";
  string public symbol = "MET";

  mapping(address => uint256) balances;
  mapping(address => mapping(address => uint256)) allowances;

  constructor(uint256 _totalSupply) public {
    totalSupply = _totalSupply;
    balances[msg.sender] = totalSupply;
  }

  function balanceOf(address _who) constant public returns (uint256 balance) {
    return balances[_who];
  }

  function allowance(address _owner, address _spender) constant public returns (uint256 value) {
    return allowances[_owner][_spender];
  }

  function transfer(address _to, uint256 _value) public returns (bool success) {
    require(_value > 0);
    require(balances[msg.sender] >= _value);

    balances[msg.sender] = balances[msg.sender].sub(_value);
    balances[_to] = balances[_to].add(_value);

    /* if (emit(Transfer(msg.sender, _to, _value))) {
      return true;
    } else {
      return false;
    } */
    return true;
  }

  function allow(address _spender, uint256 _value) public returns (bool success) {
    require(_value > 0);
    allowances[msg.sender][_spender] = allowances[msg.sender][_spender].add(_value);
    return true;
  }

  event Transfer(address _from, address _to, uint256 _value);
}
