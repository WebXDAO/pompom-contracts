// SPDX-License-Identifier: MIT
pragma solidity ^0.8.2;

import "@openzeppelin/contracts/token/ERC1155/ERC1155.sol";
import "@openzeppelin/contracts/token/ERC1155/extensions/ERC1155Supply.sol";
import "@openzeppelin/contracts/utils/Counters.sol";

contract POM is ERC1155, ERC1155Supply {
    using Counters for Counters.Counter;
    Counters.Counter private _tokenIds;
    mapping(uint256 => string) private _tokenURIs;
    uint256 totalmint = 2;
    uint256 totalTransfer = 1;
    // mapping(address => uint256) private _host;
    struct POMItem {
        uint itemId;
        uint256 tokenId;
        address payable host;
        address payable guest;
    }
    mapping(uint256 => POMItem) private idToPOMItem;
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
        address _guest, 
        string memory uri
    )
        public returns (uint256)
    {
        _tokenIds.increment();
        uint256 newItemId = _tokenIds.current();

        _mint(_guest, newItemId, totalmint, "");
        _setTokenURI(newItemId, uri);
        idToPOMItem[newItemId] =  POMItem (
            newItemId,
            newItemId,
            payable(msg.sender),
            payable(_guest)
        );
        return newItemId;
    }
    function confirmPOM(
        uint256 id
    ) public{
        // require(balanceOf(_host[], uint256 _id))
        require(balanceOf(msg.sender, id) > 1);
        safeTransferFrom(msg.sender, idToPOMItem[id].host, id, totalTransfer, "");

    }
    // The following functions are overrides required by Solidity.

    function _beforeTokenTransfer(address operator, address from, address to, uint256[] memory ids, uint256[] memory amounts, bytes memory data)
        internal
        override(ERC1155, ERC1155Supply)
    {
        super._beforeTokenTransfer(operator, from, to, ids, amounts, data);
    }
    function POMInline() public view returns (POMItem[] memory) {
        uint totalItemCount = _tokenIds.current();
        uint itemCount = 0;
        uint currentIndex = 0;
        for(uint i = 0; i < totalItemCount; i++) {
            if (balanceOf(msg.sender, i+1) > 1) {
                itemCount += 1;
            }
        }
        POMItem[] memory items = new POMItem[](itemCount);
        for (uint i = 0; i < totalItemCount; i++) {
            if (balanceOf(msg.sender, i+1) > 1){
                uint currentId = i + 1;
                POMItem storage currentItem = idToPOMItem[currentId];
                items[currentIndex] = currentItem;
                currentIndex += 1;
            }
        }
        return items;
    }
    function POMCreated() public view returns (POMItem[] memory) {
        uint totalItemCount = _tokenIds.current();
        uint itemCount = 0;
        uint currentIndex = 0;
        for(uint i = 0; i < totalItemCount; i++) {
            if (balanceOf(msg.sender, i+1) == 1) {
                itemCount += 1;
            }
        }
        POMItem[] memory items = new POMItem[](itemCount);
        for (uint i = 0; i < totalItemCount; i++) {
            if (balanceOf(msg.sender, i+1) == 1){
                uint currentId = i + 1;
                POMItem storage currentItem = idToPOMItem[currentId];
                items[currentIndex] = currentItem;
                currentIndex += 1;
            }
        }
        return items;
    }
}
