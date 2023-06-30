// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.15;

import "foundry-huff/HuffDeployer.sol";
import "forge-std/Test.sol";
import "forge-std/console.sol";

contract FirstApplicationTest is Test {
    /// @dev Address of the SimpleStore contract.
    FirstApplication public firstApplication;

    /// @dev Setup the testing environment.
    function setUp() public {
        firstApplication = FirstApplication(HuffDeployer.deploy("FirstApplication"));
    }

    /// @dev Ensure that you can set and get the value.
    function testGet() public {
        uint256 ans = firstApplication.get();
        assertEq(0,ans);
   
    }

    function testInc() public {
        firstApplication.inc();
        uint256 ans = firstApplication.get();
        assertEq(1,ans);
    }

    function testDec() public {
        for(uint256 i=0; i<10; ++i) {
            firstApplication.inc();
        }
        firstApplication.dec();
        uint256 ans = firstApplication.get();
        assertEq(9,ans);
    }

    function testDoesRevertOnUnderflow() public {
        vm.expectRevert();
        firstApplication.dec();
    }
}

interface FirstApplication {
    function get() external returns (uint256);
    function inc() external;
    function dec() external;
}