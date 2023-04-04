// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "solmate/tokens/ERC721.sol";
import "openzeppelin-contracts/contracts/utils/Strings.sol";
import "openzeppelin-contracts/contracts/access/Ownable.sol";

contract NFTDemo is ERC721, Ownable  {
    
    using Strings for uint256;
    string public baseURI;
    uint256 public currentTokenId;
    uint256 public constant TOTAL_SUPPLY = 10000;
    uint256 public constant MINT_PRICE = 0.08 ether;

    constructor(
        string memory _name,
        string memory _symbol,
        string memory _baseURI
    ) ERC721(_name, _symbol) {
        baseURI = _baseURI;
    }

    //鑄造
    function mintTo(address recipient) public payable returns (uint256) {
        if (msg.value != MINT_PRICE) {
            //如果給的錢不等於鑄造費用
            revert ("Mint Price Not Paid");
        }
        uint256 newTokenId = ++currentTokenId;
        if (newTokenId > TOTAL_SUPPLY) {
            //如果鑄造數量已達最大
            revert ("Max Supply");
        }
        _safeMint(recipient, newTokenId);
        return newTokenId;
    }

    //取得tokenUri
    function tokenURI(uint256 tokenId)
        public
        view
        virtual
        override
        returns (string memory)
    {
        if (ownerOf(tokenId) == address(0)) {
            //tokenUri不存在
            revert ("Non Existent TokenURI");
        }
        return
            bytes(baseURI).length > 0
                ? string(abi.encodePacked(baseURI, tokenId.toString(), ".json"))
                : "";
    }

    //提款
    function withdrawPayments(address payable payee) external onlyOwner {
        uint256 balance = address(this).balance;
        (bool transferTx, ) = payee.call{value: balance}("");
        if (!transferTx) {
            revert ("Withdraw Transfer Fail");
        } else {
            revert ("Withdraw Transfer Success");
        }
    }
}
