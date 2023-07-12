# Arrays

Intermediate contract showcasing arrays under the hood. How to push, pop, read, write, and get the length of a dynamic array.

Arrays, like mappings, are confusing until you get that "aha!" moment. In my opinion, the Solidity docs weren't as simple at first to grasp regarding dynamic arrays, but after reading it over several times and practicing a lot, it clicks.

[Solidity Docs Explanation](https://docs.soliditylang.org/en/v0.8.20/internals/layout_in_storage.html#mappings-and-dynamic-arrays) says that the first item in our array is found at `keccack256(p)` such that p is the slot. To get each following value we take the index add that to the hash of the slot. So if we want to get the value located at a uint256[] at index 3, it would be:
`keccack256(p) + 3` to get the hash and use `SLOAD` mnemonic to get the value. This concept is applied recursively over multi-dimensional arrays. See the above link to the Solidity docs for more information.

Solidity contract for comparison:

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

contract Array {
    // Several ways to initialize an array
    uint[] public arr;
    uint[] public arr2 = [1, 2, 3];
    // Fixed sized array, all elements initialize to 0
    uint[10] public myFixedSizeArr;

    function get(uint i) public view returns (uint) {
        return arr[i];
    }

    // Solidity can return the entire array.
    // But this function should be avoided for
    // arrays that can grow indefinitely in length.
    function getArr() public view returns (uint[] memory) {
        return arr;
    }

    function push(uint i) public {
        // Append to array
        // This will increase the array length by 1.
        arr.push(i);
    }

    function pop() public {
        // Remove last element from array
        // This will decrease the array length by 1
        arr.pop();
    }

    function getLength() public view returns (uint) {
        return arr.length;
    }

    function remove(uint index) public {
        // Delete does not change the array length.
        // It resets the value at index to it's default value,
        // in this case 0
        delete arr[index];
    }

    function examples() external {
        // create array in memory, only fixed size can be created
        uint[] memory a = new uint[](5);
    }
}

```
