// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

import "../mixins/MixinResolver.sol";
import "../mixins/Owned.sol";

contract Universe is Owned, MixinResolver {
    mapping(address => bool) public allowed;
    
    constructor(address _owner, address _resolver) Owned(_owner) MixinResolver(_resolver) {
    }

    function allow(address item) external {
        allowed[item] = true;
    }
}