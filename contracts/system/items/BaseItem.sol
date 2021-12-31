// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

import "@openzeppelin/contracts/token/ERC1155/ERC1155.sol";
import "../../mixins/MixinResolver.sol";
import "../../mixins/Owned.sol";

contract BaseItem is Owned, MixinResolver, ERC1155 {
    constructor(address _owner, address _resolver) Owned(_owner) MixinResolver(_resolver) ERC1155("https://game.example/api/item/{id}.json") {
        // Mint 10,000 of token to sender, with ID 0.
        _mint(msg.sender, 0, 1e18 * 10000, abi.encode(""));
    }
}