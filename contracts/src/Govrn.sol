// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.10;

contract Govrn {

    string public name;
    string public symbol;
    uint256 public contributionCount;

    constructor(string memory _name, string memory _symbol) {
        name = _name;
        symbol = _symbol;
    }

    // struct ContributionType {

    // }

    struct Contribution {
        address owner;
        string name;
        string details;
        uint256 dateOfSubmission;
        uint256 dateOfEngagement;
        // bytes proof;
        // bytes partners;
    }

    struct Attestation {
        uint256 contribution;
        uint8 confidence;
        uint256 dateOfSubmission;
    }

    mapping(uint256 => Contribution) internal contributions;

    function mint(
        address _whom,
        string memory _name,
        string memory _details,
        uint256 _dateOfSubmission,
        uint256 _dateOfEngagement
    ) public {
        contributions[0] = Contribution(_whom, _name, _details, _dateOfSubmission, _dateOfEngagement);
    }

    // onlyOwner
    function moveContribution(address _newOwner) internal {
        // move owner to new address
    }

    // function _transfer() public pure override {
    //     revert('no touching');
    // }
}
