# Constants

From [Huff Docs](https://docs.huff.sh/get-started/huff-by-example/#constants): Constants in Huff contracts are not included in the contract's storage; Instead, they are able to be called within the contract at compile time. Constants can either be bytes (32 max) or a `FREE_STORAGE_POINTER`. A `FREE_STORAGE_POINTER` constant will always represent an unused storage slot in the contract.

In order to push a constant to the stack, use bracket notation: `[CONSTANT]`

In our example we used `[FAVORITE_NUMBER]` to store the hex value 0x1a4 which is 420 in decimal.

Constants are often used to mark free storage pointers -- which will come in handy when youre building huff contracts because this is how we keep track of storage variables often.

Since there are no predefined types in huff, reference types in particular are tricky to build from the ground up. Arrays, structs, and mappings in particular are decently complex puzzles that are made a little bit easier through use of well defined constants.

Solidity counterpart:

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

contract Constants {
    // coding convention to uppercase constant variables
    address public constant MY_ADDRESS = 0x777788889999AaAAbBbbCcccddDdeeeEfFFfCcCc;
    uint public constant MY_UINT = 123;
}
```
