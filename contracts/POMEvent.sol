// SPDX-License-Identifier: MIT
pragma solidity ^0.8.2;
import "./NFTContract.sol";
import "@openzeppelin/contracts/security/ReentrancyGuard.sol";
contract POMEvent is ReentrancyGuard{
  uint _eventIds;
  // Counters.Counter private _eventCompleted;
  // don't need tokenId as there will be only two token per tokencontract
  event POMFactoryCreated(address collectionAddress);
  struct EventItem {
    uint eventId;
    address nftContract;
    address payable host; //crator
    address payable guest; // guest joining
  }
  event EventItemCreated (
    uint indexed eventId,
    address indexed nftContract,
    address host,
    uint256 guest
  );
  mapping(uint256 => EventItem) private idToEvent;
  
  function createPOM(
    address _guest
    ) public{
      POMPOM newCollectionAddress = new POMPOM(_guest);
      emit POMFactoryCreated(address(newCollectionAddress));
      // return address(newCollectionAddress);
      // if the event is notcompleted then guest will be able see a card. 
      // sign
    _eventIds++;
    uint256 eventId = _eventIds;
  
    idToEvent[eventId] =  EventItem(
      eventId,
      address(newCollectionAddress),
      payable(msg.sender),
      payable(_guest)
    );
  }
}