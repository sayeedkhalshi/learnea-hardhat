import { ethers, run } from "hardhat";

async function main() {
    //console.log("Deploying contracts with the account:", deployer.address);

    // Deploy FlashLoanExample contract
    const Learnea = await ethers.getContractFactory("Learnea");
    const [deployer] = await ethers.getSigners();
    const nonce = await deployer.getNonce();
    console.log("Deploying Learnea contract with nonce:", nonce);
    const learnea = await Learnea.deploy({
        nonce: nonce,
    });

    console.log("NFT contract address:", learnea.target);
}
//}

// Run the deployment

main()
    .then(() => process.exit(0))
    .catch((error) => {
        console.error(error);
        process.exit(1);
    });
