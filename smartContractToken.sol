pragma solidity >=0.5.0 <0.5.17;

import 'https://github.com/OpenZeppelin/openzeppelin-contracts/blob/release-v2.5.0/contracts/math/SafeMath.sol';

contract smrtToken {

    using SafeMath for uint;
    
    address payable owner = msg.sender;
    string public symbol = 'SMRT';
    uint public exchange_rate = 100;

    mapping(address => uint) balances;

    function balance() public view returns(uint) {
        return balances [msg.sender];
    }

    function transfer(address recipient, uint value) public {
        
        balances[msg.sender] = balances[msg.sender].sub(value);
        balances[recipient] = balances[recipient].add(value);
    }

    function purchase() public payable {
        
        uint amount = msg.value.mul(exchange_rate);
        balances[msg.sender] = amount;
        balances[owner] = balances[owner].sub(amount);
        owner.transfer(msg.value);
    }

    function mint(address contractOwner, uint value) public {
        require(msg.sender == owner, 'Only Smart Contract Owner can mint tokens!');
        balances[contractOwner] = value;
    }
}