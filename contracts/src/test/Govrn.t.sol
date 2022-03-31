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
		partners[0] = address(this);
		govrn.mint(address(this), "test", "here", 1, 2, "proof", partners);
		bool exists = govrn.partners(0, address(this));
		assertTrue(exists);
    }

    //function testBulkMintTwo() public {
	//	address[] memory partners;
	//	Govrn.BulkContribution[] memory contributions = new Govrn.BulkContribution[](2);
	//	contributions[0] = Govrn.BulkContribution(Govrn.Contribution(address(this), "test3", "here", 1, 2, "proof"), partners);
	//	contributions[1] = Govrn.BulkContribution(Govrn.Contribution(address(this), "test4", "here", 1, 2, "proof"), partners);
	//	govrn.bulkMint(contributions);

	//	 (, bytes memory name,,,,) = govrn.contributions(1);
	//	assertTrue(keccak256(name) == keccak256("test3"));
	//	 (, bytes memory name2,,,,) = govrn.contributions(2);
	//	assertTrue(keccak256(name2) == keccak256("test4"));
    //}
}
