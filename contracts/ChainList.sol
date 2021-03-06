// SPDX-License-Identifier: MIT
pragma solidity >=0.4.0 <0.9.0;

contract ChainList {
  // state variables
  address payable seller;
  address buyer;
  string name;
  string description;
  uint256 price;

  // events
  event LogSellArticle(
    address indexed _seller,
    string _name,
    uint256 _price
  );
  event LogBuyArticle(
    address indexed _seller,
    address indexed _buyer,
    string _name,
    uint256 _price
  );

  // sell an article
  function sellArticle(string memory _name, string memory _description, uint256 _price) public {
    seller = msg.sender;
    name = _name;
    description = _description;
    price = _price;

    LogSellArticle(seller, name, price);
  }

  // get an article
  function getArticle() public view returns (
    address _seller,
    address _buyer,
    string memory _name,
    string memory _description,
    uint256 _price
  ) {
      return(_seller,
    _buyer,
    _name,
    _description,
    _price);
  }

  // buy an article
  function buyArticle() payable public {
    // we check whether there is an article for sale
    require(seller != 0x0);

    // we check that the article has not been sold yet
    require(buyer == 0x0);

    // we don't allow the seller to buy his own article
    require(msg.sender != seller);

    // we check that the value sent corresponds to the price of the article
    require(msg.value == price);

    // keep buyer's information
    buyer = msg.sender;

    // the buyer can pay the seller
    seller.transfer(msg.value);

    // trigger the event
    LogBuyArticle(seller, buyer, name, price);
  }
}
