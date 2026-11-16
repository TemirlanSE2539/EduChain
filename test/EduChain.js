const { expect } = require("chai");
const { ethers } = require("hardhat");

describe("EduChain", function () {
  let admin;
  let university;
  let anotherUser;
  let registry;
  let credential;

  const diplomaId = ethers.id("diploma-001");
  const diplomaHash = ethers.id("demo-diploma-data");

  beforeEach(async function () {
    [admin, university, anotherUser] = await ethers.getSigners();

    const Registry = await ethers.getContractFactory("IssuerRegistry");
    registry = await Registry.deploy();
    await registry.waitForDeployment();

    const Credential = await ethers.getContractFactory("CredentialAnchor");
    credential = await Credential.deploy(await registry.getAddress());
    await credential.waitForDeployment();

    await registry.addUniversity(university.address, "Demo University");
  });

  it("adds a university", async function () {
    expect(await registry.isUniversityActive(university.address)).to.equal(true);
  });

  it("does not allow another user to add a university", async function () {
    await expect(
      registry.connect(anotherUser).addUniversity(anotherUser.address, "Other University")
    ).to.be.revertedWith("Only admin");
  });

  it("allows an active university to anchor a diploma", async function () {
    await credential.connect(university).addDiploma(diplomaId, diplomaHash);
    expect(await credential.checkDiploma(diplomaId, diplomaHash)).to.equal(true);
  });

  it("does not allow an unregistered user to add a diploma", async function () {
    await expect(
      credential.connect(anotherUser).addDiploma(diplomaId, diplomaHash)
    ).to.be.revertedWith("University is not active");
  });

  it("does not allow the same diploma ID twice", async function () {
    await credential.connect(university).addDiploma(diplomaId, diplomaHash);
    await expect(
      credential.connect(university).addDiploma(diplomaId, diplomaHash)
    ).to.be.revertedWith("Diploma already exists");
  });

  it("allows the issuing university to revoke its diploma", async function () {
    await credential.connect(university).addDiploma(diplomaId, diplomaHash);
    await credential.connect(university).revokeDiploma(diplomaId);
    expect(await credential.checkDiploma(diplomaId, diplomaHash)).to.equal(false);
  });

  it("does not allow another user to revoke a diploma", async function () {
    await credential.connect(university).addDiploma(diplomaId, diplomaHash);
    await expect(
      credential.connect(anotherUser).revokeDiploma(diplomaId)
    ).to.be.revertedWith("Not your diploma");
  });

  it("does not verify a diploma with a wrong hash", async function () {
    await credential.connect(university).addDiploma(diplomaId, diplomaHash);
    expect(await credential.checkDiploma(diplomaId, ethers.id("wrong-data"))).to.equal(false);
  });

  it("does not verify a diploma after its university is blocked", async function () {
    await credential.connect(university).addDiploma(diplomaId, diplomaHash);
    await registry.blockUniversity(university.address);
    expect(await credential.checkDiploma(diplomaId, diplomaHash)).to.equal(false);
  });
});
