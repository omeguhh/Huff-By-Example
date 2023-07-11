// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.15;

import "foundry-huff/HuffDeployer.sol";
import "forge-std/Test.sol";
import "forge-std/console.sol";


interface Mappings {
    function getAllowance(address _from, address _spender) external returns(uint256);
    function increaseAllowance(address _spender, uint256 _amount) external returns(uint256);
    function decreaseAllowance(address _spender, uint256 _amount) external returns(uint256);
}
contract MappingsTest is Test {
    Mappings public mappings;
    address payable omeguhh = payable(vm.addr(420));

    function setUp() public {
        mappings = Mappings(HuffDeployer.deploy("Mappings"));
        vm.deal(omeguhh, 100 ether);
    }

    function testIncreaseAllowance() public {
        vm.prank(omeguhh);
        uint256 allowance = mappings.increaseAllowance(address(this), 10 ether);
        uint256 myAllowance = mappings.getAllowance(omeguhh, address(this));
        assertEq(allowance, myAllowance);
        assertEq(allowance, 10 ether);

    }

    function testDecreaseAllowance() public {
        vm.startPrank(omeguhh);
        uint256 allowance = mappings.increaseAllowance(address(this), 10 ether);
        vm.expectRevert();
        mappings.decreaseAllowance(address(this), 20 ether);
        uint256 myAllowance = mappings.decreaseAllowance(address(this), 5 ether);
        assertEq(allowance - 5 ether, myAllowance);
        assertEq(myAllowance, 5 ether);
        vm.stopPrank();
    }

}
