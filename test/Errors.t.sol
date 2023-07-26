// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.15;

import "foundry-huff/HuffDeployer.sol";
import "forge-std/Test.sol";
import "forge-std/console.sol";

contract ErrorsTest is Test {
    /// @dev Address of the SimpleStore contract.
    Errors public errors;
    uint256 constant ARITHMETIC_OVERFLOW = 0x11;

    /// @dev Setup the testing environment.
    function setUp() public {
        errors = Errors(HuffDeployer.deploy("Errors"));
    }

    /// @dev Ensure that you can set and get the value.
    function testGet() public {
        uint256 ans = errors.get();
        assertEq(0,ans);
   
    }

    function testInc() public {
        errors.inc();
        uint256 ans = errors.get();
        assertEq(1,ans);
    }

    function testDec() public {
        for(uint256 i=0; i<10; ++i) {
            errors.inc();
        }
        errors.dec();
        uint256 ans = errors.get();
        assertEq(9,ans);
    }

    function testDoesRevertOnUnderflow() public {
        (bool success, bytes memory revertMessage) = address(errors).call(
           abi.encodeWithSignature("dec()")
        );
        assertEq(success, false, "Call expected to revert but it didn't");
        assertEq(
            keccak256(abi.encode(bytes4(revertMessage))),
            keccak256(abi.encode(bytes4(keccak256("Underflow()")))),
            "Expected the call to revert with custom error 'Underflow()' but it didn't "
        );
    }
    
    function testDoesRevertOnOverflow() public {
        errors.set(type(uint256).max);
        vm.expectRevert();
        errors.inc();
        
    }
}

interface Errors {
    function get() external returns (uint256);
    function set(uint256) external;
    function inc() external;
    function dec() external;
}