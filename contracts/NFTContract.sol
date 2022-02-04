// SPDX-License-Identifier: MIT
pragma solidity ^0.8.2;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/utils/Counters.sol";

contract POMPOM is ERC721, ERC721URIStorage{
    using Counters for Counters.Counter;

    Counters.Counter private _tokenIdCounter;
    address Guest;
    constructor(
        address _Guest
    ) ERC721("POMPOM", "POM") {
        Guest = _Guest;
    }
    modifier onlyGuest(){
        require(msg.sender == Guest);
        _;
    }
    function safeMint(address _host, address _guest, string memory uri) public onlyGuest {
        uint256 tokenId = _tokenIdCounter.current();
        _tokenIdCounter.increment();
        _safeMint(_host, tokenId);
         _setTokenURI(tokenId, uri);
        _tokenIdCounter.increment();
        _safeMint(_guest, tokenId);
        _setTokenURI(tokenId, uri);
    }
    // The following functions are overrides required by Solidity.

    function _burn(uint256 tokenId) internal override(ERC721, ERC721URIStorage) {
        super._burn(tokenId);
    }

    function tokenURI(uint256 tokenId)
        public
        view
        override(ERC721, ERC721URIStorage)
        returns (string memory)
    {
        return super.tokenURI(tokenId);
    }
}