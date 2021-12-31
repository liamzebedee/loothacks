// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/token/ERC721/IERC721.sol";
import "@openzeppelin/contracts/token/ERC1155/IERC1155.sol";

import "../mixins/MixinResolver.sol";
import "../mixins/Owned.sol";
import "../libraries/Utils.sol";
import "./blueprints/Blueprint.sol";
import "./Universe.sol";

error Illegal();

contract Fabricator is Owned, MixinResolver {
    constructor(address _owner, address _resolver) Owned(_owner) MixinResolver(_resolver) {
    }

    // Makes an object according to a blueprint, transferring inputs to the 
    // owner of the fabricator.
    function make(Blueprint blueprint, uint256[9] calldata ids, uint256[9] calldata amounts) public {
        Universe universe = Universe(requireAndGetAddress("Universe"));
        if (!universe.allowed(address(blueprint)))
            revert Illegal();
        
        for(uint i = 0; i < blueprint.numInputs(); i++) {
            (address token, TokenType inputType, uint256 id, uint256 amount) = blueprint.inputs(i);

            if(token == address(0)) continue;

            if(inputType == TokenType.ERC20) {
                IERC20(token).transferFrom(msg.sender, owner, amount);
            }
            if(inputType == TokenType.ERC721) {
                IERC721(token).transferFrom(msg.sender, owner, id);
            }
            if(inputType == TokenType.ERC1155) {
                IERC1155(token).safeTransferFrom(msg.sender, owner, id, amount, abi.encode(""));
            }
        }

        (address item, uint256 id, uint256 amount) = blueprint.getOutputForInputs();
        blueprint.mint(msg.sender, item, id, amount);
    }
}