import { HardhatUserConfig } from "hardhat/config";
import "@nomicfoundation/hardhat-toolbox";
import * as dotenv from "dotenv";

dotenv.config();

const config: HardhatUserConfig = {
  solidity: "0.8.25",
  defaultNetwork: "hardhat",
  networks: {
    //amoy: {
    //  url: process.env.AMOY_RPC || "",
    //  accounts: [process.env.PRIVATE_KEY || ""],
    //  chainId: 80002
    //}
  },
  etherscan: {
    apiKey: process.env.POLYGONSCAN_KEY
  }
};
export default config;