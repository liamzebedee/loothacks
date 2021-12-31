// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

import "../../mixins/MixinResolver.sol";
import "../../mixins/Owned.sol";
import "../../libraries/Utils.sol";

// A trade-up contract lets users trade a batch of items of a similar value
// for one item of higher value. It is directly inspired by the same tool
// in Counterstrike [1].
// [1]: https://counterstrike.fandom.com/wiki/Trade_Up_Contract
contract TradeUpContract is Owned, MixinResolver {
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

    struct Bucket {
        Output[] outputs;
        uint numOutputs;
    }

    // The list of inputs required to fabricate this item.
    Input[9] public inputs;
    uint[] public bucketsRanges;
    mapping(uint => Bucket) buckets;

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

    // Get the expected output of a trade from a set of input items. 
    // The output is probabilistically selected using the nonce value.
    // e.g. 
    // 1. Average quality of items is computed as 95.
    // 2. 95 is mapped into the "ultrarare" bucket.
    // 3. A random item is probabilistically selected from this bucket.
    function getOutputForInputs(uint256[9] calldata ids, uint256[9] calldata amounts, uint256 nonce) public view returns (Output memory output) {
        // Sum of quality for all items.
        uint256 avg = 0;
        for(uint i = 0; i < inputs.length; i++) {
            if(inputs[i].item == address(0)) {
                avg /= i + 1; // divide by count
                continue;
            }

            // sum values
            avg += _getValue(inputs[i].item, ids[i], amounts[i]);
        }

        // binary search for bucket.
        uint floor = 0;
        uint ceil = bucketsRanges.length;
        while(floor < ceil) {
            uint guessIndex = (floor + ceil) / 2;
            uint guessValue = bucketsRanges[guessIndex];
            if(guessValue > avg) {
                floor = guessIndex;
            } else {
                ceil = guessIndex;
            }
        }

        Bucket storage bucket = buckets[floor];

        // randomly pick one item from the bucket
        // and mint it to the user.
        Output storage output = bucket.outputs[nonce % bucket.numOutputs];
        return output;
    }

    // Returns the value of an item, as a score between 0 - 16000.
    function _getValue(address item, uint id, uint amount) public pure returns (uint16) {
        // Up to the implementer.
        return 100;
    }
}