import { ethers } from "hardhat";

async function main() {
  const credential = await ethers.deployContract("CredentialNFT");
  await credential.waitForDeployment();
  console.log("CredentialNFT deployed:", credential.target);

  const registry = await ethers.deployContract("ExamRegistry", [credential.target]);
  await registry.waitForDeployment();
  console.log("ExamRegistry deployed:", registry.target);

  await credential.transferOwnership(registry.target);
  console.log("Registry now owns NFT contract");
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});