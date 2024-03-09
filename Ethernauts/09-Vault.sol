// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Token {

    address target = 0xB78C8AC6d8307C4DeA93ECaFeDE2A00dd440AB5f;
    uint256 password = 0x412076657279207374726f6e67207365637265742070617373776f7264203a29;
    // A very strong secret password :)
    

    function unlock_vault() public {
        bytes memory payload = abi.encodeWithSignature("unlock(bytes32)", bytes32(password));
        (bool success, ) = target.call(payload);
        
        assert(success);
    }

}