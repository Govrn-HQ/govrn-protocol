// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.10;

// 1. mint a single contribution
// 2. bulk mint contributions
// 3.Add events

// function balanceOf(address _owner) external view returns (uint256);
// function ownerOf(uint256 _tokenId) external view returns (address);

contract Govrn {

    uint256 public contributionCount = 0;

    constructor() {}

    struct Contribution {
        address owner;
        bytes name;
        bytes details;
        uint256 dateOfSubmission;
        uint256 dateOfEngagement;
		bytes proof;
    }

    // struct Attestation {
    //     uint256 contribution;
    //     uint8 confidence;
    //     uint256 dateOfSubmission;
    // }

    mapping(uint256 => Contribution) public contributions;
    mapping(uint256 => mapping(address => bool)) public partners;

    function mint(
        address _owner,
        bytes memory _name,
        bytes memory _details,
        uint256 _dateOfSubmission,
        uint256 _dateOfEngagement,
        bytes memory _proof,
		address[] memory _partners
    ) public {
		require(_owner != address(0), "INVALID_RECIPIENT");
		if(contributions[contributionCount].owner != address(0)) {
		  contributionCount++;
		}

       contributions[contributionCount] = Contribution(_owner, _name, _details, _dateOfSubmission, _dateOfEngagement, _proof);
       for (uint i = 0; i < _partners.length; i++) {
		  partners[contributionCount][_partners[i]] = true;
        }


		// This needs some sort of reentry guard thing
		// we have to make sure there is an increment or weirdness can happen
		contributionCount++;
    }

}
