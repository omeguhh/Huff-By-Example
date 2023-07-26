# Errors

Simple contract displaying our old `FirstApplication.huff` contract with **new** errors.

Errors are defined using `#define error ERROR_NAME`. They can take arguments or be left blank depending on your needs.

To call an error, we use `__ERROR(ERROR_NAME)` and we can store any arguments for this error revert with a starting offset of 4 bytes `0x04`. We need to save these items in memory, and then call them using

```huff
0x20
push0
revert
```

if there is no argument, or

```huff
0x24
push0
revert
```

to take a single argument.

Another good example of reverts comes from the [Huffmate](https://github.com/huff-language/huffmate/blob/main/src/utils/Errors.huff) repository, which shows how to build require, panic, and asserts.

Solidity contract for comparison:

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

contract Error {
    function testRequire(uint _i) public pure {
        // Require should be used to validate conditions such as:
        // - inputs
        // - conditions before execution
        // - return values from calls to other functions
        require(_i > 10, "Input must be greater than 10");
    }

    function testRevert(uint _i) public pure {
        // Revert is useful when the condition to check is complex.
        // This code does the exact same thing as the example above
        if (_i <= 10) {
            revert("Input must be greater than 10");
        }
    }

    uint public num;

    function testAssert() public view {
        // Assert should only be used to test for internal errors,
        // and to check invariants.

        // Here we assert that num is always equal to 0
        // since it is impossible to update the value of num
        assert(num == 0);
    }

    // custom error
    error InsufficientBalance(uint balance, uint withdrawAmount);

    function testCustomError(uint _withdrawAmount) public view {
        uint bal = address(this).balance;
        if (bal < _withdrawAmount) {
            revert InsufficientBalance({balance: bal, withdrawAmount: _withdrawAmount});
        }
    }
}
```
