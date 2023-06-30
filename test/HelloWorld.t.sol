// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.15;

import "foundry-huff/HuffDeployer.sol";
import "forge-std/Test.sol";
import "forge-std/console.sol";

contract HelloWorldTest is Test {
    /// @dev Address of the SimpleStore contract.
    HelloWorld public helloWorld;

    /// @dev Setup the testing environment.
    function setUp() public {
        helloWorld = HelloWorld(HuffDeployer.deploy("HelloWorld"));
    }

    /// @dev Ensure that you can set and get the value.
    function testGetGreeting() public {
        bytes memory ans = helloWorld.getGreeting();
        assertEq(bytes("Hello, world!"), ans, "Expected to be a greeting.");
   
    }
}

interface HelloWorld {
    function getGreeting() external returns (bytes memory);
}