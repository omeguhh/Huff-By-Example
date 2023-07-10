// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.15;

import "foundry-huff/HuffDeployer.sol";
import "forge-std/Test.sol";
import "forge-std/console.sol";


interface Loops {
    function maxArray(
        uint256[] calldata nums
    ) external returns (uint256);
}
contract LoopsTest is Test {
    Loops public loops;

    function setUp() public {
        loops = Loops(HuffDeployer.deploy("Loops"));
    }

    function testMaxOfArray() external {
        uint256[] memory arr = new uint256[](10);
        arr[0] = 2;
        arr[1] = 4;
        arr[2] = 262;
        arr[3] = 8;
        arr[4] = 4;
        arr[5] = 1;
        arr[6] = 0;
        arr[7] = 17;
        arr[8] = 67251781;
        arr[9] = 27;

        uint256 x = loops.maxArray(arr);
        assertEq(x, 67251781, "expected max of arr to be 67251781");

        uint256[] memory arr2 = new uint256[](0);
        vm.expectRevert();
        loops.maxArray(arr2);

        uint256[] memory arr3 = new uint256[](5);
        arr3[0] = 2;
        arr3[1] = 7;
        arr3[2] = 7;
        arr3[3] = 5;
        arr3[4] = 4;
        x = loops.maxArray(arr3);
        assertEq(x, 7, "expected max of arr to be 7");
    }

}
