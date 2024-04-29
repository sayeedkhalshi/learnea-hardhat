import { HardhatUserConfig } from "hardhat/config";
import "@nomicfoundation/hardhat-toolbox";
import dotenv from "dotenv";

dotenv.config();

const PRIVATE_KEY = process.env.PRIVATE_KEY || "0x";
const ETH_SEPOLIA_ALCHEMY_RPC = process.env.ETH_SEPOLIA_ALCHEMY_RPC;

const config: HardhatUserConfig = {
    solidity: "0.8.18",
    networks: {
        base: {
            url: "https://mainnet.base.org",
            accounts: [PRIVATE_KEY],
            chainId: 8453,
        },
        polygon: {
            url: process.env.POLYGON_RPC_URL,
            accounts: [PRIVATE_KEY],
            chainId: 137,
        },
        sepolia: {
            url: ETH_SEPOLIA_ALCHEMY_RPC,
            accounts: [PRIVATE_KEY],
            chainId: 11155111,
        },

        lineaTestnet: {
            url: "https://linea-sepolia.infura.io/v3/",
            accounts: [PRIVATE_KEY],
            chainId: 59141,
        },
        lineaGoerli: {
            url: "https://linea-goerli.infura.io/v3/",
            accounts: [PRIVATE_KEY],
            chainId: 59140,
        },
        tabiTestnet: {
            url: "https://rpc.testnet.tabichain.com",
            accounts: [PRIVATE_KEY],
            chainId: 9789,
        },
        vanguard: {
            url: "https://rpc-vanguard.vanarchain.com",
            accounts: [PRIVATE_KEY],
            chainId: 78600,
        },
        tenTestnet: {
            url: "https://testnet.ten.xyz/v1/?token=66a94ca7ff8715ae7ecb0cd7a2a9065de1330c02",
            accounts: [PRIVATE_KEY],
            chainId: 443,
        },
        readonTestnet: {
            url: "https://pre-alpha-zkrollup-rpc.opside.network/readon-content-test-chainh",
            accounts: [PRIVATE_KEY],
            chainId: 12015,
        },
    },
};

export default config;
