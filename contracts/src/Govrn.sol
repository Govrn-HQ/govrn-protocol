// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.13;


contract Govrn {

    uint256 public contributionCount = 0;

    /*//////////////////////////////////////////////////////////////
                            EIP-712 STORAGE
    //////////////////////////////////////////////////////////////*/

    uint256 internal immutable INITIAL_CHAIN_ID;
    bytes32 internal immutable INITIAL_DOMAIN_SEPARATOR;
    string public constant VERSION = "0.1";


    constructor() {
      INITIAL_CHAIN_ID = block.chainid;
      INITIAL_DOMAIN_SEPARATOR = computeDomainSeparator();
	}

    struct Contribution {
        address owner;
        bytes name;
        bytes details;
        uint256 dateOfSubmission;
        uint256 dateOfEngagement;
		bytes proof;
    }
	struct BulkContribution {
		Contribution contribution;
		address[] partners;
	}

    struct Attestation {
        uint256 contribution;
        uint8 confidence;
        uint256 dateOfSubmission;
    }

    mapping(address => uint256) public balanceOf;
    mapping(uint256 => Contribution) public contributions;
    mapping(uint256 => mapping(address => bool)) public partners;
	mapping(uint256 => mapping(address => Attestation)) public attestations;
	mapping(address => uint256) public nonces;

	/// Events
    event Mint(address indexed owner, uint256 id);
    event Attest(address indexed attestor, uint256 contribution, uint8 confidence);


   function DOMAIN_SEPARATOR() public view virtual returns (bytes32) {
        return block.chainid == INITIAL_CHAIN_ID ? INITIAL_DOMAIN_SEPARATOR : computeDomainSeparator();
    }

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
		balanceOf[_owner]++;
		emit Mint(_owner, contributionCount);
		contributionCount++;
    }

    function bulkMint(
      BulkContribution[] memory _contributions
    ) public {

       for (uint i = 0; i < _contributions.length; i++) {
		  BulkContribution memory bulk  = _contributions[i];
		  this.mint(bulk.contribution.owner, bulk.contribution.name, bulk.contribution.details, bulk.contribution.dateOfSubmission, bulk.contribution.dateOfEngagement, bulk.contribution.proof, bulk.partners);
        }

    }

	// verify contribution exists
	// verify sender is not 0 address
	function attest(
		uint256 _contribution,
		uint8 _confidence
	) public {
		require(contributions[_contribution].owner != address(0), "Contribution does not exist" );
		require(attestations[_contribution][msg.sender].dateOfSubmission == 0, "Attestation exists" );

		Attestation memory attestation = Attestation({
		  contribution: _contribution,
		  confidence: _confidence,
		  dateOfSubmission: block.timestamp
		});
		attestations[_contribution][msg.sender] = attestation;
		emit Attest(msg.sender, _contribution, _confidence);
	}

	function permitAttest(address _attestor,
						  uint256 _contribution,
						  uint8 _confidence,
						  uint256 _dateOfSubmission,
						  uint256 _deadline,
                          uint8 v,
                          bytes32 r,
                          bytes32 s) public {
       require(_deadline >= block.timestamp, "PERMIT_DEADLINE_EXPIRED");
	   uint256 nonce = nonces[_attestor];
	   nonces[_attestor]++;

        // Unchecked because the only math done is incrementing
        // the owner's nonce which cannot realistically overflow.
        unchecked {
            address recoveredAddress = ecrecover(
                keccak256(
                    abi.encodePacked(
                        "\x19\x01",
                        DOMAIN_SEPARATOR(),
                        keccak256(
                            abi.encode(
                                    keccak256("Attest(address attestor,uint256 contribution,uint8 confidence,uint256 dateOfSubmission,uint256 nonce,uint256 deadline)"
                                ),
                                _attestor,
								_contribution,
                                _confidence,
                                _dateOfSubmission,
								nonce,
                                _deadline
                            )
                        )
                    )
                ),
                v,
                r,
                s
            );

            require(recoveredAddress != address(0) && recoveredAddress == _attestor, "INVALID_SIGNER");
		    require(contributions[_contribution].owner != address(0), "Contribution does not exist" );
		    require(attestations[_contribution][msg.sender].dateOfSubmission == 0, "Attestation exists" );
		    Attestation memory attestation = Attestation({
		      contribution: _contribution,
		      confidence: _confidence,
		      dateOfSubmission: _dateOfSubmission
		    });
		    attestations[_contribution][_attestor] = attestation;

        }
		emit Attest(_attestor, _contribution, _confidence);
	}

    function ownerOf(uint256 _tokenId) external view returns (address) {
		return contributions[_tokenId].owner;
	}

    function computeDomainSeparator() internal view virtual returns (bytes32) {
        return
            keccak256(
                abi.encode(
                    keccak256("EIP712Domain(string name,string version,uint256 chainId,address verifyingContract)"),
                    keccak256(bytes("Govrn")),
                    keccak256(bytes(VERSION)),
                    block.chainid,
                    address(this)
                )
            );
    }


}
