// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract AJSToken is ERC20, Ownable {
  event TokensMinted(address indexed receiver, uint256 amount);

  enum Item {
    AJSToken_OVEN,
    AJSToken_BLENDER,
    AJSToken_IRON,
    AJSToken_DRYER,
    AJSToken_COFFEE_MAKER
  }
  mapping(Item => uint256) public itemPrices;

  constructor() ERC20("AJSToken", "AJS") Ownable(msg.sender) {
    _mint(msg.sender, 10000 * 0**decimals());

    itemPrices[Item.AJSToken_OVEN] = 25;
    itemPrices[Item.AJSToken_OVEN] = 50;
    itemPrices[Item.AJSToken_IRON] = 75;
    itemPrices[Item.AJSToken_DRYER] = 100;
    itemPrices[Item.AJSToken_COFFEE_MAKER] = 125;
  }

  function mint(address _to, uint256 _amount) public onlyOwner {
    _mint(_to, _amount);
    emit TokensMinted(_to, _amount);
  }

  function transferTokens(address _to, uint256 _amount) public {
    _transfer(msg.sender, _to, _amount);
  }

  function redeemTokens(Item _item) public {
    uint256 itemPrice = itemPrices[_item];
    require(balanceOf(msg.sender) >= itemPrice, "You have insufficient funds, try again");


    _burn(msg.sender, itemPrice);
  }

  function checkTokenBalance(address _player) public view returns (uint256) {
    return balanceOf(_player);
  }

  function burnTokens(uint256 _amount) public {
    require(balanceOf(msg.sender) >= _amount, "You have insufficient funds, try again");
    _burn(msg.sender, _amount);
  }
}