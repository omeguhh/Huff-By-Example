# Simple Storage

Simple contract to read and write to storage.
Remember when writing constants that are set to `FREE_STORAGE_POINTER` you can use brackets ([]) to reference them in your macros.

In the Simple Storage Test contract we fuzz our setter just to double check we're not running into any issues.

Comparable solidity contract for reference:

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

contract SimpleStorage {
    // State variable to store a number
    uint public num;

    // You need to send a transaction to write to a state variable.
    function set(uint _num) public {
        num = _num;
    }

    // You can read from a state variable without sending a transaction.
    function get() public view returns (uint) {
        return num;
    }
}
```
