# Mappings

Intermediate contract showcasing how mappings work in Huff.

Mappings are relatively straightforward conceptually as a key-value pair. See the following short excerpt from Zac Williamson:

_Mappings work by combining the mapping key with the storage slot of the mapping, and hashing the result. The result is a 32 byte storage pointer that unique both to the key being used, and the mapping variable in question._

To achieve this end, we use a new mnemonic `sha3` which takes an offset in memory, and a byte size to copy from memory, and returns a 32 byte keccack-256 hash.

If this is still a little confusing, no worries. Think of it like any other key -> value mapping. This Keccack-256 hash serves as our key that allows us to access the specific value we are looking for. In the case of Huff, the part you may want to pay careful attention to is the creation of the **key**.

For simple balance mapping of address -> amount it looks like this:
**values in memory**

```
0x00 ----------------------------------------------------- address
0x20 ----------------------------------------------------- balance slot

0x40 push0 sha3                                            //[amount]
```

Where `0x40` is the size of the data in memory (we are using two full words) that equals 64 in decimal. `push0` is our offset in memory.

Simple enough right? In previous sections, we worked through storing a value into a storage variable. This is very similar to that, just with a couple extra steps.

Solidity contract for comparison:

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

contract Mapping {
    // Mapping from address to uint
    mapping(address => uint) public myMap;

    function get(address _addr) public view returns (uint) {
        // Mapping always returns a value.
        // If the value was never set, it will return the default value.
        return myMap[_addr];
    }

    function set(address _addr, uint _i) public {
        // Update the value at this address
        myMap[_addr] = _i;
    }

    function remove(address _addr) public {
        // Reset the value to the default value.
        delete myMap[_addr];
    }
}

contract NestedMapping {
    // Nested mapping (mapping from address to another mapping)
    mapping(address => mapping(uint => bool)) public nested;

    function get(address _addr1, uint _i) public view returns (bool) {
        // You can get values from a nested mapping
        // even when it is not initialized
        return nested[_addr1][_i];
    }

    function set(address _addr1, uint _i, bool _boo) public {
        nested[_addr1][_i] = _boo;
    }

    function remove(address _addr1, uint _i) public {
        delete nested[_addr1][_i];
    }
}
```
