// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

/// @notice Create an ERC20 token with adjustable initial parameters
contract ApetasticERC20 is ERC20 {

    /// @param name The name of the token
    /// @param symbol The symbol of the token
    /// @param mintTo The address that the initial supply should be sent to
    /// @param supply The totalSupply of the token
    constructor(
        string memory name,
        string memory symbol,
        address mintTo,
        uint256 supply
    ) ERC20(name, symbol) {
        _mint(mintTo, supply);
    }
}
