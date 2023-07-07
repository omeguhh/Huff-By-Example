// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.15;

import "foundry-huff/HuffDeployer.sol";
import "forge-std/Test.sol";
import "forge-std/console.sol";

contract SimpleStorageTest is Test {
    /// @dev Address of the SimpleStore contract.
    SimpleStorage public simple;

    /// @dev Setup the testing environment.
    function setUp() public {
        simple = SimpleStorage(HuffDeployer.deploy("SimpleStorage"));
    }

    /// @dev Ensure that you can set and get the value.
    function testSet() public {
        simple.set(420);
        assertEq(simple.get(), 420);
    }

    function testGet() public {
        simple.set(420);
        assertEq(simple.get(), 420);
        simple.set(69);
        assertEq(simple.get(), 69);
        simple.set(0);
        assertEq(simple.get(), 0);
    }

    function testFuzzSet(uint256 num) public {
        simple.set(num);
        assertEq(simple.get(), num);
    }

}

interface SimpleStorage {
    function set(uint256) external;
    function get() external returns(uint256);
}