// SPDX-License-Identifier: BUSL-1.1
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import {HuffDeployer} from "foundry-huff/HuffDeployer.sol";

interface Arrays {
    function push(uint256 num) external;

    function popLast() external;

    function read(uint256 index) external view returns (uint256);

    function length() external view returns (uint256);

    function write(uint256 index, uint256 num) external;
}

contract ArraysTest is Test {
    Arrays public simulateArray;

    function setUp() public {
        simulateArray = Arrays(HuffDeployer.deploy("Arrays"));
    }

    function testSimulateArrayReverts() external {
        assertEq(
            simulateArray.length(),
            0,
            "length is initially meant to be 0"
        );

        vm.expectRevert();
        simulateArray.popLast();

        vm.expectRevert();
        simulateArray.read(0);

        vm.expectRevert();
        simulateArray.write(0, 1);
    }

    function testSimulateArray() external {
        assertEq(
            simulateArray.length(),
            0,
            "length is initially meant to be 0"
        );

        simulateArray.push(42);
        assertEq(simulateArray.length(), 1, "expected length to be 1");
        assertEq(simulateArray.read(0), 42, "expected arr[0] to be 42");

        simulateArray.push(24);
        assertEq(simulateArray.length(), 2, "expected length to be 2");
        assertEq(simulateArray.read(0), 42, "expected arr[0] to be 42");
        assertEq(simulateArray.read(1), 24, "expected arr[1] to be 24");

        simulateArray.write(0, 122);
        assertEq(simulateArray.length(), 2, "expected length to be 2");
        assertEq(simulateArray.read(0), 122, "expected arr[0] to be 122");
        assertEq(simulateArray.read(1), 24, "expected arr[1] to be 24");

        simulateArray.write(1, 346);
        assertEq(simulateArray.length(), 2, "expected length to be 2");
        assertEq(simulateArray.read(0), 122, "expected arr[0] to be 122");
        assertEq(simulateArray.read(1), 346, "expected arr[1] to be 346");

        simulateArray.popLast();
        assertEq(simulateArray.length(), 1, "expected length to be 1");
        assertEq(simulateArray.read(0), 122, "expected arr[0] to be 122");
        vm.expectRevert();
        simulateArray.read(1);
    }
    
}