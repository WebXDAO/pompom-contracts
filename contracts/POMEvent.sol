// SPDX-License-Identifier: MIT
pragma solidity ^0.8.2;
import "./NFTContract.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "@openzeppelin/contracts/security/ReentrancyGuard.sol";
contract POMEvent is ReentrancyGuard{
  Counters.Counter private _eventIds;
  Counters.Counter private _eventCompleted;
  event POMFactoryCreated(address collectionAddress);
  struct EventItem {
    uint eventId;
    address nftContract;
    uint256 tokenId;
    address payable host; //crator
    address payable guest; // guest joining
  }
  event EventItemCreated (
    uint indexed eventId,
    address indexed nftContract,
    uint256 indexed tokenId,
    address host,
    uint256 guest
  );
  mapping(uint256 => EventItem) private idToEvent;
  function createPOM(
    address _host
    ) public returns(address){
      POMPOM newCollectionAddress = new POMPOM(_host);
      emit POMFactoryCreated(address(newCollectionAddress));
      // return address(newCollectionAddress);
      // if the event is notcompleted then guest will be able see a card. 
      // sign
  }
}