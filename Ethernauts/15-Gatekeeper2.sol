// SPDX-License-Identifier: MIT
pragma solidity ^0.8.*;

// Gate 1: use a contract
// Gate 2: extcodesize(caller()) == 0
// Gate 3: uint64(bytes8(keccak256(abi.encodePacked(msg.sender)))) ^ uint64(_gateKey) == type(uint64).max

contract Gatekeeper2 {

    address target = 0x5177bE88dBde35a2Df7F2C91E73EE5d389eec4Bf;
    event TestBool(bool);
    event TestUint(uint256);

    constructor () {

        bytes8 key = bytes8(uint64(bytes8(keccak256(abi.encodePacked(address(this))))) ^ type(uint64).max);

        require(uint64(bytes8(keccak256(abi.encodePacked(address(this))))) ^ uint64(key) == type(uint64).max);

        bytes memory payload = abi.encodeWithSignature("enter(bytes8)", key);
        (bool success, ) = target.call(payload);
        emit TestBool(success);
    }
}