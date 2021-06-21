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

import "./ERC20/ERC20Initializable.sol";
import "./ERC20/SafeERC20.sol";
import "./utils/Ownable.sol";


contract ApetasticERC20Factory is Ownable {
    using SafeERC20 for IERC20;
    bytes32 public constant INIT_CODE_TOKEN_HASH = keccak256(abi.encodePacked(type(ERC20Initializable).creationCode));

    address[] public allTokens;

    event TokenCreated(address indexed tokenAddress, uint256 startingSupply);

    /// @dev Return the number of tokens created by this contract
    function allTokensLength() external view returns (uint) {
        return allTokens.length;
    }

    /// @dev Create a new ERC-20 contract
    /// @param name The name of the token
    /// @param symbol The symbol of the token
    /// @param supply The totalSupply of the token
    function createToken(string memory name, string memory symbol, uint256 supply) external returns (address) {
        ERC20Initializable token = new ERC20Initializable();
        token.initialize(name, symbol, msg.sender, supply);
        allTokens.push(address(token));
        emit TokenCreated(address(token), supply);
        return address(token);
    }

    /// @notice A public function to sweep accidental ERC20 transfers to this contract. 
    ///   Tokens are sent to owner
    /// @param token The address of the ERC20 token to sweep
    function sweepToken(IERC20 token) external onlyOwner {
        uint256 balance = token.balanceOf(address(this));
        token.safeTransfer(msg.sender, balance);
    }
}
