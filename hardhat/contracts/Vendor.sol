pragma solidity 0.8.4; //Do not change the solidity version as it negativly impacts submission grading
// SPDX-License-Identifier: MIT

import { Ownable } from "@openzeppelin/contracts/access/Ownable.sol";
import { YourToken } from "./YourToken.sol";


contract Vendor is Ownable {
  error WithdrawFailure();
  error SentBackEthFailure();

  event BuyTokens(address buyer, uint256 amountOfETH, uint256 amountOfTokens);
  event SellTokens(address seller, uint256 amountOfTokens, uint256 amountOfETH);

  YourToken public yourToken;

  // Constant
  uint256 public constant tokensPerEth = 100;

  constructor(address tokenAddress) {
    yourToken = YourToken(tokenAddress);
  }

  /**
      ! : values are sent in wei 
   */
  function buyTokens() public payable {
    // Convert eth to tokens
    uint256 amountOfTokens = msg.value * tokensPerEth;
    yourToken.transfer(msg.sender, amountOfTokens);
    // after transfer emit event
    emit BuyTokens(msg.sender, msg.value, amountOfTokens);
  }

  // ToDo: create a withdraw() function that lets the owner withdraw ETH
  // disable this function to not be public and easily accessibile to kill the vendor liquidity
  function withdraw() public onlyOwner {
    (bool sent,) = payable(msg.sender).call{value: address(this).balance}("");
    if (!sent) {
      revert WithdrawFailure();
    }
  }

  // ToDo: create a sellTokens(uint256 _amount) function:
  function sellTokens(uint256 _amount) public {
    // Send token to the Vendor
    bool sentTokens = yourToken.transferFrom(msg.sender, address(this), _amount);
    require(sentTokens, "Token transfer failed");
    // Send eth to sender
    // Do not miss to divide to tokenPerEth since we send an amount of eth and not token
    uint256 amountEth = _amount / tokensPerEth;
    (bool sentEth,) = payable(msg.sender).call{value: amountEth}("");
    if (!sentEth) {
      revert SentBackEthFailure();
    }
    // Emit sell tokens event
    emit SellTokens(msg.sender, _amount, amountEth);
  }
}
