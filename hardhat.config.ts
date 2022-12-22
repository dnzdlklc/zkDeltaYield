require("@matterlabs/hardhat-zksync-deploy");
require("@matterlabs/hardhat-zksync-solc");

module.exports = {
    zksolc: {
        version: "1.2.1",
        compilerSource: "binary",  // binary or docker
        settings: {
            compilerPath: "zksolc",  // ignored for compilerSource: "docker"
            experimental: {
                dockerImage: "matterlabs/zksolc", // required for compilerSource: "docker"
                tag: "latest"   // required for compilerSource: "docker"
            },
            libraries:{} // optional. References to non-inlinable libraries
        }
    },
    defaultNetwork: "zkTestnet",
    networks: {
        zkTestnet: {
            url: "https://zksync2-testnet.zksync.dev", // URL of the zkSync network RPC
            ethNetwork: "goerli", // Can also be the RPC URL of the Ethereum network (e.g. `https://goerli.infura.io/v3/<API_KEY>`)
            zksync: true
        },
        hardhat: {
            zksync: true  // enables zksync in hardhat local network
        }
    },
    solidity: {
        version: "0.8.16",
    },
};