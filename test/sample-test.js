const { expect } = require("chai");
const { ethers } = require("hardhat");

describe("Greeter", function () {
  it("Should return the new greeting once it's changed", async function () {
    const [host, guest] = await ethers.getSigners();
    const POMEvent = await ethers.getContractFactory("POMEvent");
    const pomevent = await POMEvent.deploy("POM event deployed");
    await pomevent.deployed();
    const POMEventAddress = pomevent.address
    
  });
});
