// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.10;

import "ds-test/test.sol";
import "../Govrn.sol";

contract ContractTest is DSTest {
    Govrn govrn;

    function setUp() public {
      govrn = new Govrn();
	}

    function testNewContribution() public {
		address[] memory partners;
		govrn.mint(address(this), "test", "here", 1, 2, "proof",partners);
		 (address owner, bytes memory name, bytes memory details, uint256 dateOfSubmission, uint256 dateOfEngagement, bytes memory proof) = govrn.contributions(0);
		assertTrue(owner == address(this));
		assertTrue(keccak256(name) == keccak256("test"));
		assertTrue(keccak256(details) == keccak256("here"));
		assertTrue(dateOfSubmission == 1);
		assertTrue(dateOfEngagement == 2);
		assertTrue(keccak256(proof) == keccak256("proof"));
    }

    function testNewContributionNoPartners() public {
		bool exists = govrn.partners(0, address(this));
		assertTrue(exists == false);
    }

    function testNewContributionWithPartners() public {
		address[] memory partners = new address[](1);
		govrn.mint(address(this), "test", "here", 1, 2, "proof", partners);
		bool exists = govrn.partners(0, address(this));
		assertTrue(exists);
    }


}
