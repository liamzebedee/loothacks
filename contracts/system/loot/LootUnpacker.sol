// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

import "../../mixins/MixinResolver.sol";
import "../../mixins/Owned.sol";

contract LootUnpacker is Owned, MixinResolver {
    constructor(address _owner, address _resolver) Owned(_owner) MixinResolver(_resolver) {
    }

    function unpack(uint id) public view {
        // transfer loot pack to this contract
        // mint a set of loot items
    }
}