// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

enum Stat {
    ATTACK,
    DEFENCE
}

contract LootStats {
    function getStats() public view returns (uint[9] memory stats) {
        stats[uint256(Stat.ATTACK)] = 12;
        stats[uint256(Stat.DEFENCE)] = 12;
    }
}