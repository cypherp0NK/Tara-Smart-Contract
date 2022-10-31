//SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.0;

import "@openzeppelin/contracts/security/ReentrancyGuard.sol";
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Counters.sol";

contract Tara is ERC721, ERC721URIStorage, ReentrancyGuard {

    using Counters for Counters.Counter;
    using SafeERC20 for ERC20;
    Counters.Counter private _idCounter;

    address public uniToken; 
    address public founder;
    uint256 public mintPrice;

    constructor(
       address _uniToken,
       address _founder,
       uint256 _mintPrice
    ) ERC721("Tara", "Tara") {
        uniToken = _uniToken;
        founder = _founder;
        mintPrice = _mintPrice;
    }

    function mint(address to, string memory uri) external nonReentrant{

        require(to != address(0) && to != address(this), "to");
        ERC20(uniToken).safeTransferFrom(
            msg.sender,
            founder,
            mintPrice
        );
        uint256 tokenId = _idCounter.current();
        _idCounter.increment();
        _safeMint(to, tokenId);
        _setTokenURI(tokenId, uri);

    }

    function _burn(uint256 tokenId) internal override (ERC721, ERC721URIStorage) {
        super._burn(tokenId);
    }

    function tokenURI(uint256 tokenId) public view override (ERC721, ERC721URIStorage) returns (string memory){
        return super.tokenURI(tokenId);
    }
}