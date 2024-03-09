// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/interfaces/IERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

interface CryptoVault {
    function sweepToken(IERC20 token) external;
}

interface LegacyToken {

    function transfer(address to, uint256 value) external returns (bool);
}

interface IForta {
    function usersDetectionBots(address) external pure returns (IDetectionBot);
    function setDetectionBot(address detectionBotAddress) external;
    function notify(address user, bytes calldata msgData) external;
    function raiseAlert(address user) external;
}

interface IDetectionBot {
    function handleTransaction(address user, bytes calldata msgData) external;
}


contract Bot is IDetectionBot {

    address vault = 0x9E64B1982601Dcf3E22e1f99E02293412D894bb9;
    address det_token = 0xD98b597cD9DD5c9F454E54F0cFCc2335b8c2B4B6;
    address leg_token = 0xbbD9980629a354020cEc60e798b04dE88c247fDd;
    address forta = 0xE96cEb3923929ce22CB7435e42340627aA4D7b61;
    address player = 0xD64D08C68F6940281c51108734B5b5DA95f62BD5;
    event TestBool(bool);
    event TestUint(uint256);
    event TestAddr(address);
    
    function handleTransaction(address user, bytes calldata msgData) external {

        address msgDataAddr = abi.decode(msgData[msgData.length-32:], (address));
        emit TestAddr(msgDataAddr);

        if(msgDataAddr == vault) {
            IForta(forta).raiseAlert(player);
        }
    }
}