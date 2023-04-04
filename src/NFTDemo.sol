// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "solmate/tokens/ERC721.sol";
import "openzeppelin-contracts/contracts/utils/Strings.sol";
import "openzeppelin-contracts/contracts/access/Ownable.sol";

contract NFTDemo is ERC721, Ownable {
    using Strings for uint256;
    uint256 public currentTokenId;
    uint256 public constant TOTAL_SUPPLY = 10000; //最大數量
    uint256 public constant MINT_PRICE = 10000 wei; //鑄造費用
    bool private isBoxOpened = false; //盲盒控制打開與否
    string private baseUri; //圖片uri
    string private unrevealedURI; //盲盒圖片uri

    constructor(
        string memory _name,
        string memory _symbol,
        string memory _baseUri,
        string memory _unrevealedURI
    ) ERC721(_name, _symbol) {
        baseUri = _baseUri;
        unrevealedURI = _unrevealedURI;
    }

    //打開盲盒
    function openBox() external onlyOwner {
        isBoxOpened = true;
    }

    //關閉盲盒
    function closeBox() external onlyOwner {
        isBoxOpened = false;
    }

    //鑄造
    function mintTo(address recipient) public payable returns (uint256) {
        if (msg.value != MINT_PRICE) {
            //如果給的錢不等於鑄造費用
            revert("Mint Price Not Paid");
        }
        uint256 newTokenId = ++currentTokenId;
        if (newTokenId > TOTAL_SUPPLY) {
            //如果鑄造數量已達最大
            revert("Max Supply");
        }
        _safeMint(recipient, newTokenId);
        return newTokenId;
    }

    //取得base Uri
    function _baseURI() internal view returns (string memory) {
        return isBoxOpened ? baseUri : unrevealedURI;
    }

    //取得token Uri
    function tokenURI(
        uint256 _tokenId
    ) public view override returns (string memory) {
        require(_tokenId <= TOTAL_SUPPLY, "Token ID not exist!!");
        string memory baseURI = _baseURI();
        return bytes(baseURI).length > 0 ? string(abi.encodePacked(baseURI,Strings.toString(_tokenId),".json")): "";
    }

    //提款
    function withdrawPayments(address payable payee) external onlyOwner {
        uint256 balance = address(this).balance;
        (bool transferTx, ) = payee.call{value: balance}("");
        if (!transferTx) {
            revert("Withdraw Transfer Fail");
        }
    }
}
