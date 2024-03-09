// SPDX-License-Identifier: MIT
pragma solidity ^0.8.*;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract FakeToken is ERC20("FakeToken", "FAKE") {

    constructor (uint256 initialSupply) {
        _mint(msg.sender, initialSupply);
    }

}