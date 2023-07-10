# Loops

Explanation on loops in Huff, using an array to demonstrate multiple intermediate topics.

Loops -- especially looping through an array -- can be tough at first in Huff. In the If/Else section we showed working with `JUMPI` which is a conditional jump. `JUMP` will jump to whatever program counter the JUMPDEST points to.

We add an additional challenge by throwing in an array to sort and find the greatest value in the array. Dynamic arrays specifically are more work to understand, as they are broken up into three pieces, each 1 full word, 32 bytes each.

1st word: Offset
2nd word: Length
3rd word: Data

To iterate and compare each item (in our case, number) in an array, we need to determine how to GET each number in the array so we can compare a > b.

To do this we can take our data location (0x44 which includes 4 byte offset of function signature) and in our case of working with uint256 we just add 0x20 (32 bytes / 1 word) to find the location of the next number (using calldataload to get the value ofc).

We also need to make sure we do not go out of bounds. So in similar fashion we check to make sure that after each loop have we reached the point where current index is equal to length-1? That is what this block of code does:

```huff
continue:
        //compare current index with length of array to determine end of loop
        0x01 add                                //[idx[i+1],arr[i+1],lLoc,dLoc]
        dup1 dup4 calldataload                  //[length,idx[i],arr[i],lLoc,dLoc]
        0x01 swap1 sub                          //[lth-1,idx[i],arr[i],lLoc,dLoc]
        eq end jumpi                            //[idx[i],arr[i],lLoc,dLoc]
```

If we reach the end of the array, we do a conditional jump (`JUMPI`) to `end` another `JUMPDEST` where we return the max value of the array.

Solidity contract for comparison:

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

contract Loop {
    function loop() public {
        // for loop
        for (uint i = 0; i < 10; i++) {
            if (i == 3) {
                // Skip to next iteration with continue
                continue;
            }
            if (i == 5) {
                // Exit loop with break
                break;
            }
        }

        // while loop
        uint j;
        while (j < 10) {
            j++;
        }
    }
}
```
