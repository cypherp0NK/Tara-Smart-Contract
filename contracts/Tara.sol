//SPDX-License-Identifier: Unlicense

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

    address public uniToken = 0x1f9840a85d5aF5bf1D1762F925BDADdC4201F984; 
    address public founder = 0xA3288c8DF6B54aE08c610e06B4Cf9fc48Eb51316;
    uint256 public mintPrice = 20000000000000000;

    constructor() ERC721("Tara", "Tara") {
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
