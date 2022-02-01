// SPDX-License-Identifier: MIT
pragma solidity ^0.8.2;
import "./NFTContract.sol";
contract POMFactory{
  event POMFactoryCreated(address collectionAddress);
  function createPOM(
    // uint256 _price
    ) public returns(address){
      POMPOM newCollectionAddress = new POMPOM(msg.sender);
      emit POMFactoryCreated(address(newCollectionAddress));
      return address(newCollectionAddress);
  }
}
