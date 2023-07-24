// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.15;

import "foundry-huff/HuffDeployer.sol";
import "forge-std/Test.sol";
import "forge-std/console.sol";

contract EnumTest is Test {
    /// @dev Address of the SimpleStore contract.
    Enum public enums;

    /// @dev Setup the testing environment.
    function setUp() public {
        enums = Enum(HuffDeployer.deploy("Enum"));
    }

    /// @dev Ensure that you can set and get the value.
    function testGet() public {
        uint256 ans = enums.getStep();
        assertEq(0, ans);
   
    }

    function testSet() public {
        enums.setStep(3);
        uint256 ans = enums.getStep();
        assertEq(3, ans);
        vm.expectRevert();
        enums.setStep(5);
    }
}

interface Enum {
    function getStep() external returns (uint256);
    function setStep(uint256 _step) external;
}