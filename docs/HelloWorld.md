# Hello, world!

Implementation of a getter that returns the greeting "Hello, world!". Since Huff is a low level EVM language, you'd be right in assuming that it's more complex than the same contract using solidity:

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

contract HelloWorld {

    function getGreeting() public pure returns(string) {
        return "Hello, world!";
    }
}
```

Strings are dynamic arrays and are built in in 3 seperate, 32 byte words.

1. Offset
2. Length
3. Data

In the `HelloWorld.huff` file, this is represented in memory as:

```solidity
0x00            0000000000000000000000000000000000000000000000000000000000000020
0x20            000000000000000000000000000000000000000000000000000000000000000d
0x40            48656c6c6f2c20776f726c642100000000000000000000000000000000000000
```
