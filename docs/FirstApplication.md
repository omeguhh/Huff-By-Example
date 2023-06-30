# First Application

Contract that can increment or decrement a "count" state variable and `get` it. While solidity versions from 0.8.0 and up all revert on overflow and underflow, we need to manually check.

Now that we are working with more functions, you'll notice the importance of tidy comments to keep track of what you are putting on and taking off the stack.

Additionally, due to the structure of Huff, it is IMPORTANT that you terminate ALL of your top-level macros with some form of escape opcode (`return`,`stop`,`revert`). If you don't do this your macro WILL continue to execute which ever macro is inlined next until a return condition is found.

This is also covered in the **Linear Dispatching** subsection of Function Dispatching in the Huff Docs Tutorials.

Below is the solidity version of our Huff contract from SCP website:

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

contract Counter {
    uint public count;

    // Function to get the current count
    function get() public view returns (uint) {
        return count;
    }

    // Function to increment count by 1
    function inc() public {
        count += 1;
    }

    // Function to decrement count by 1
    function dec() public {
        // This function will fail if count = 0
        count -= 1;
    }
}
```

In our `FirstApplication.huff` file, we define a named storage pointer, which sits at slot 0.

If we were to have one come after it, it would sit at slot 1, the one after would sit at slot 2, and so on.

To use these pointers, just wrap it in a set of brackets.
