// SPDX-License-Identifier: MIT
pragma solidity ^0.8.*;

// 0x6080604052348015600e575f80fd5b50600f80601a5f395ff3fe5f5f602a5f5260205ff3
/*
// Boilerplate for deployment
PUSH1 0x80
PUSH1 0x40
MSTORE
CALLVALUE
DUP1
ISZERO
PUSH1 0x0e
JUMPI
PUSH0
DUP1
REVERT
JUMPDEST
POP
PUSH1 0x0a
DUP1
PUSH1 0x1a
PUSH0
CODECOPY
PUSH0
RETURN
INVALID

// Payload
PUSH0
PUSH0
PUSH1 0x2a
PUSH0
MSTORE
PUSH1 0x20
PUSH0
RETURN
*/


contract MagicNumber {

    address target = 0x2805342f0AB0eDE7096150aba7b061d479e0fba9;

    event TestBool(bool);
    event TestUint(uint256);

    function send(address solver) public {

        bytes memory payload = abi.encodeWithSignature("setSolver(address)", address(solver));
        (bool success, ) = target.call(payload);
        emit TestBool(success);
    }

    function test(address solver) public view returns (uint256) {

        uint256 size;
        assembly {
            size := extcodesize(solver)
        }
        return size;
    }
}
