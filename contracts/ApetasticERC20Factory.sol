// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

/*
 * ApeSwapFinance 
 * App:             https://apeswap.finance
 * Medium:          https://ape-swap.medium.com    
 * Twitter:         https://twitter.com/ape_swap 
 * Telegram:        https://t.me/ape_swap
 * Announcements:   https://t.me/ape_swap_news
 * GitHub:          https://github.com/ApeSwapFinance
 */

import "./ApetasticERC20.sol";
import "@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

/// @title A smart contract for generating ERC-20 tokens
/// @author Apetastic
contract ApetasticERC20Factory is Ownable {
    using SafeERC20 for IERC20;

    address public beneficiary;
    address[] public allTokens;

    event TokenCreated(address indexed tokenAddress, uint256 startingSupply);
    event TransferBeneficiary(address indexed oldBeneficiary, address indexed beneficiary);
    event SweepToken(IERC20 indexed token, address indexed beneficiary, uint256 balance);

    /// @dev On contract creation the beneficiary (and owner) are set to msg.sender
    constructor() {
        beneficiary = msg.sender;
    }

    /// @notice Return the number of tokens created by this contract
    function allTokensLength() external view returns (uint) {
        return allTokens.length;
    }

    /// @notice Create a new ERC-20 contract
    /// @dev Tokens created have 18 decimals which means add 18 zeros the integer supply: 000000000000000000 
    /// @param name The name of the token
    /// @param symbol The symbol of the token
    /// @param supply The totalSupply of the token
    function createToken(string memory name, string memory symbol, uint256 supply) external returns (address) {
        ApetasticERC20 token = new ApetasticERC20(name, symbol, msg.sender, supply);
        allTokens.push(address(token));
        emit TokenCreated(address(token), supply);
        return address(token);
    }

    /// @notice Change the beneficiary who recieves swept tokens
    /// @param newBeneficiary The address of the new beneficiary
    function setBeneficiary(address newBeneficiary) external onlyOwner {
        address oldBeneficiary = beneficiary;
        beneficiary = newBeneficiary;
        emit TransferBeneficiary(oldBeneficiary, beneficiary);
    }

    /// @notice An external function to sweep ERC20 tokens locked in this contract.
    /// @dev Only the owner can call this function, but the tokens are transferred to the beneficiary address
    /// @param token The address of the ERC20 token to sweep
    function sweepToken(IERC20 token) external {
        uint256 balance = token.balanceOf(address(this));
        token.safeTransfer(beneficiary, balance);
        emit SweepToken(token, beneficiary, balance);
    }
}
