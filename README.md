# Solidity
Solidity Contracts currently only deployed to a personal test network

Current contracts:
- Registrar:
	This contract is used to track the versions of other contracts that exist, where a single version of the contract should be used. An implementation is tied to an individual address, and the user can track iterations of a contract with a unique string. Applications can call this contract to get the current version of the tracked contracts that should be used in an environment of the user's choosing. 
