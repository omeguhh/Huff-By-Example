# If/Else

Explanation of conditional statements in Huff using a simple add and subtract contract to determine if a value will overflow or underflow.

`JUMPI` opcode is a conditional jump to a specified `pc` (program counter). We use a named counter such as `is_underflow` and its corresponding destination `is_underflow:` to show what to do if a condition is met and where to pick up the program.

We can use this to also loop through and iterate over objects in arrays like you'll see in future sections.

Solidity contract for comparison:

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

contract IfElse {
    function foo(uint x) public pure returns (uint) {
        if (x < 10) {
            return 0;
        } else if (x < 20) {
            return 1;
        } else {
            return 2;
        }
    }

    function ternary(uint _x) public pure returns (uint) {
        // if (_x < 10) {
        //     return 1;
        // }
        // return 2;

        // shorthand way to write if / else statement
        // the "?" operator is called the ternary operator
        return _x < 10 ? 1 : 2;
    }
}
```
