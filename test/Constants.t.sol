// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.15;

import "foundry-huff/HuffDeployer.sol";
import "forge-std/Test.sol";
import "forge-std/console.sol";

contract ConstantsTest is Test {
    /// @dev Address of the SimpleStore contract.
    Constants public constants;

    /// @dev Setup the testing environment.
    function setUp() public {
        constants = Constants(HuffDeployer.deploy("Constants"));
    }

    /// @dev Ensure that you can set and get the value.
    function testGet() public {
        uint256 ans = constants.doSomething();
        assertEq(ans, 420);
   
    }
}

interface Constants {
    function doSomething() external returns (uint256);
}