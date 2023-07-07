// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.15;

import "foundry-huff/HuffDeployer.sol";
import "forge-std/Test.sol";
import "forge-std/console.sol";

contract IfElseTest is Test {

    IfElse public conditional;

    /// @dev Setup the testing environment.
    function setUp() public {
        conditional = IfElse(HuffDeployer.deploy("IfElse"));
    }

    function testCanAdd(uint256 _num) public {
        conditional.addVal(_num);
    }

    function testCanSub(uint256 _num) public {
        vm.assume(_num > 0);
        conditional.addVal(_num);
        uint256 ans = conditional.subVal(_num);
        assertEq(0, ans);
        vm.expectRevert();
        conditional.subVal(_num);
    }

}

interface IfElse {
    function addVal(uint256) external returns(uint256);
    function subVal(uint256) external returns(uint256);
}