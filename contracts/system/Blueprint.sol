// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

import "../mixins/MixinResolver.sol";
import "../mixins/Owned.sol";

enum TokenType {
    ERC20,
    ERC721,
    ERC1155
}

// A blueprint is a simple schematic for creating new items from material inputs.
// It consists of a list of inputs and a single output.
// An input can be a simple erc20, erc721 or erc1155.
contract Blueprint is Owned, MixinResolver {
    struct Input {
        address item;
        TokenType inputType;
        uint256 id;
        uint256 amount;
    }

    struct Output {
        address item;
        uint256 id;
        uint256 amount;
    }

    // The list of inputs required to fabricate this item.
    Input[9] public inputs;

    constructor(
        address _owner, 
        address _resolver
    ) Owned(_owner) MixinResolver(_resolver) {}

    function initialize(
        address[9] calldata inputsItems,
        TokenType[9] calldata inputsTokenType,
        uint256[9] calldata inputsIds,
        uint256[9] calldata inputsAmounts
    ) public {
        for(uint i = 0; i < inputsItems.length; i++) {
            if(inputsItems[i] == address(0)) continue;

            inputs[i] = Input({
                item: inputsItems[i],
                inputType: inputsTokenType[i],
                id: inputsIds[i],
                amount: inputsAmounts[i]
            });
        }
    }

    function numInputs() public pure returns (uint) {
        return 9;
    }

    function getOutput() public view returns (Output output) {
        // This can be probabilistic. It can be simple.
    }
}