pub use govrn_mod::*;
#[allow(clippy::too_many_arguments)]
mod govrn_mod {
    #![allow(clippy::enum_variant_names)]
    #![allow(dead_code)]
    #![allow(clippy::type_complexity)]
    #![allow(unused_imports)]
    use ethers::contract::{
        builders::{ContractCall, Event},
        Contract, Lazy,
    };
    use ethers::core::{
        abi::{Abi, Detokenize, InvalidOutputType, Token, Tokenizable},
        types::*,
    };
    use ethers::providers::Middleware;
    #[doc = "Govrn was auto-generated with ethers-rs Abigen. More information at: https://github.com/gakonst/ethers-rs"]
    use std::sync::Arc;
    pub static GOVRN_ABI: ethers::contract::Lazy<ethers::core::abi::Abi> =
        ethers::contract::Lazy::new(|| {
            serde_json :: from_str ("[{\"inputs\":[],\"stateMutability\":\"nonpayable\",\"type\":\"constructor\",\"outputs\":[]},{\"inputs\":[],\"stateMutability\":\"view\",\"type\":\"function\",\"name\":\"contributionCount\",\"outputs\":[{\"internalType\":\"uint256\",\"name\":\"\",\"type\":\"uint256\",\"components\":[]}]},{\"inputs\":[{\"internalType\":\"address\",\"name\":\"_owner\",\"type\":\"address\",\"components\":[]},{\"internalType\":\"string\",\"name\":\"_name\",\"type\":\"string\",\"components\":[]},{\"internalType\":\"string\",\"name\":\"_details\",\"type\":\"string\",\"components\":[]},{\"internalType\":\"uint256\",\"name\":\"_dateOfSubmission\",\"type\":\"uint256\",\"components\":[]},{\"internalType\":\"uint256\",\"name\":\"_dateOfEngagement\",\"type\":\"uint256\",\"components\":[]},{\"internalType\":\"string\",\"name\":\"_proof\",\"type\":\"string\",\"components\":[]},{\"internalType\":\"address[]\",\"name\":\"_partners\",\"type\":\"address[]\",\"components\":[]}],\"stateMutability\":\"nonpayable\",\"type\":\"function\",\"name\":\"mint\",\"outputs\":[]}]") . expect ("invalid abi")
        });
    #[derive(Clone)]
    pub struct Govrn<M>(ethers::contract::Contract<M>);
    impl<M> std::ops::Deref for Govrn<M> {
        type Target = ethers::contract::Contract<M>;
        fn deref(&self) -> &Self::Target {
            &self.0
        }
    }
    impl<M: ethers::providers::Middleware> std::fmt::Debug for Govrn<M> {
        fn fmt(&self, f: &mut std::fmt::Formatter) -> std::fmt::Result {
            f.debug_tuple(stringify!(Govrn))
                .field(&self.address())
                .finish()
        }
    }
    impl<'a, M: ethers::providers::Middleware> Govrn<M> {
        #[doc = r" Creates a new contract instance with the specified `ethers`"]
        #[doc = r" client at the given `Address`. The contract derefs to a `ethers::Contract`"]
        #[doc = r" object"]
        pub fn new<T: Into<ethers::core::types::Address>>(
            address: T,
            client: ::std::sync::Arc<M>,
        ) -> Self {
            let contract =
                ethers::contract::Contract::new(address.into(), GOVRN_ABI.clone(), client);
            Self(contract)
        }
        #[doc = "Calls the contract's `contributionCount` (0x5b18056b) function"]
        pub fn contribution_count(
            &self,
        ) -> ethers::contract::builders::ContractCall<M, ethers::core::types::U256> {
            self.0
                .method_hash([91, 24, 5, 107], ())
                .expect("method not found (this should never happen)")
        }
        #[doc = "Calls the contract's `mint` (0xdaf3ce04) function"]
        pub fn mint(
            &self,
            owner: ethers::core::types::Address,
            name: String,
            details: String,
            date_of_submission: ethers::core::types::U256,
            date_of_engagement: ethers::core::types::U256,
            proof: String,
            partners: ::std::vec::Vec<ethers::core::types::Address>,
        ) -> ethers::contract::builders::ContractCall<M, ()> {
            self.0
                .method_hash(
                    [218, 243, 206, 4],
                    (
                        owner,
                        name,
                        details,
                        date_of_submission,
                        date_of_engagement,
                        proof,
                        partners,
                    ),
                )
                .expect("method not found (this should never happen)")
        }
    }
    #[doc = "Container type for all input parameters for the `contributionCount`function with signature `contributionCount()` and selector `[91, 24, 5, 107]`"]
    #[derive(
        Clone,
        Debug,
        Default,
        Eq,
        PartialEq,
        ethers :: contract :: EthCall,
        ethers :: contract :: EthDisplay,
    )]
    #[ethcall(name = "contributionCount", abi = "contributionCount()")]
    pub struct ContributionCountCall;
    #[doc = "Container type for all input parameters for the `mint`function with signature `mint(address,string,string,uint256,uint256,string,address[])` and selector `[218, 243, 206, 4]`"]
    #[derive(
        Clone,
        Debug,
        Default,
        Eq,
        PartialEq,
        ethers :: contract :: EthCall,
        ethers :: contract :: EthDisplay,
    )]
    #[ethcall(
        name = "mint",
        abi = "mint(address,string,string,uint256,uint256,string,address[])"
    )]
    pub struct MintCall {
        pub owner: ethers::core::types::Address,
        pub name: String,
        pub details: String,
        pub date_of_submission: ethers::core::types::U256,
        pub date_of_engagement: ethers::core::types::U256,
        pub proof: String,
        pub partners: ::std::vec::Vec<ethers::core::types::Address>,
    }
    #[derive(Debug, Clone, PartialEq, Eq, ethers :: contract :: EthAbiType)]
    pub enum GovrnCalls {
        ContributionCount(ContributionCountCall),
        Mint(MintCall),
    }
    impl ethers::core::abi::AbiDecode for GovrnCalls {
        fn decode(data: impl AsRef<[u8]>) -> Result<Self, ethers::core::abi::AbiError> {
            if let Ok(decoded) =
                <ContributionCountCall as ethers::core::abi::AbiDecode>::decode(data.as_ref())
            {
                return Ok(GovrnCalls::ContributionCount(decoded));
            }
            if let Ok(decoded) = <MintCall as ethers::core::abi::AbiDecode>::decode(data.as_ref()) {
                return Ok(GovrnCalls::Mint(decoded));
            }
            Err(ethers::core::abi::Error::InvalidData.into())
        }
    }
    impl ethers::core::abi::AbiEncode for GovrnCalls {
        fn encode(self) -> Vec<u8> {
            match self {
                GovrnCalls::ContributionCount(element) => element.encode(),
                GovrnCalls::Mint(element) => element.encode(),
            }
        }
    }
    impl ::std::fmt::Display for GovrnCalls {
        fn fmt(&self, f: &mut ::std::fmt::Formatter<'_>) -> ::std::fmt::Result {
            match self {
                GovrnCalls::ContributionCount(element) => element.fmt(f),
                GovrnCalls::Mint(element) => element.fmt(f),
            }
        }
    }
    impl ::std::convert::From<ContributionCountCall> for GovrnCalls {
        fn from(var: ContributionCountCall) -> Self {
            GovrnCalls::ContributionCount(var)
        }
    }
    impl ::std::convert::From<MintCall> for GovrnCalls {
        fn from(var: MintCall) -> Self {
            GovrnCalls::Mint(var)
        }
    }
}
