// SPDX-License-Identifier: MIT
pragma solidity ^0.8.2;

import "@openzeppelin/contracts/token/ERC1155/ERC1155.sol";
import "@openzeppelin/contracts/token/ERC1155/extensions/ERC1155Supply.sol";
import "@openzeppelin/contracts/utils/Counters.sol";

contract MyToken is ERC1155, ERC1155Supply {
    using Counters for Counters.Counter;
    Counters.Counter private _tokenIds;
    uint256[1] amountTrans;
    amountTrans[1] = 1;
    uint256[1] amountMint;
    amountMint[1]=2;
    mapping(uint256 => string) private _tokenURIs;
    constructor() ERC1155("") {

    }

    function _setTokenURI(uint256 tokenId, string memory _tokenURI)
        internal
        virtual
    {
        _tokenURIs[tokenId] = _tokenURI;
    }
    
    function tokenURI(uint256 tokenId)
        public
        view
        virtual
        returns (string memory)
    {
        require(exists(tokenId), "Token doesn't exist");
        string memory _tokenURI = _tokenURIs[tokenId];
        return _tokenURI;
    }

    function createPOM(
        address account, 
        string memory uri
    )
        public returns (uint256)
    {
        _tokenIds.increment();
        uint256 newItemId = _tokenIds.current();
        _mint(account, newItemId, amountMint[1], "");
        _setTokenURI(newItemId, uri);
        return newItemId;
    }
    function confirmPOM(
        address _guest,
        uint256[] memory ids
    ) public{
        safeBatchTransferFrom(msg.sender, _guest, ids, amountTrans[1])
    }
    function mintBatch(address to, uint256[] memory ids, uint256[] memory amounts)
        public
    {
        _mintBatch(to, ids, amounts, "");
    }
    // The following functions are overrides required by Solidity.

    function _beforeTokenTransfer(address operator, address from, address to, uint256[] memory ids, uint256[] memory amounts, bytes memory data)
        internal
        override(ERC1155, ERC1155Supply)
    {
        super._beforeTokenTransfer(operator, from, to, ids, amounts, data);
    }
}