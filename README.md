# Apetastic ERC20 Factory
This repository serves as an example of how to use factory contracts to deploy other contracts without needing to run a cli deployment or use Remix. 

The factory deploys a standard OpenZeppelin ERC-20 contract which has been extended to mint the initial supply to the token creator. 

## OpenZeppelin
OZ is the OG of smart contract development and they continue to hone their skills. 

https://docs.openzeppelin.com/contracts 
## Install 
Click "Use as Template" to create a repo on GitHub based on this repo. Otherwise:  
`git clone git@github.com:DeFiFoFum/truffle-typescript-template.git`   
  
`yarn install`

## Setup
Create a `.env` file based off of `.env.example` to deploy contracts to bsc mainnet/testnet and to verify deployed contracts.  

## Compile
`yarn compile`

## Deploy 

### Mainnet
`yarn migrate:bsc [--reset]` // Use `--reset` to redeploy already deployed contracts   
`yarn verify:bsc`  

### Testnet
`yarn migrate:testnet [--reset]`  
`yarn verify:testnet`  
  
_* new contracts that are added must be added to the verification script in package.json by adding `&&` to the end with the new contract verification._


## Lint
Lint with `solhint`  
`yarn lint` / `yarn lint:fix`    

## Generate Types from Contracts
Use `typechain` to generate contract interfaces for UI integration.  
`yarn gen:types`  

