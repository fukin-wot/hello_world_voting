npm install -g webpack
truffle unbox webpack
remove ConvertLib.sol and MetaCoin.sol
write contract file in ./contracts/

in /migrations/2_deploy_contract.js, write:
    var Voting = artifacts.require('./Voting.sol');

    module.exports = function (deployer) {
    deployer.deploy(Voting, ['sacros', 'sacra', 'anct'], { gas: 6700000 });
    };


for deploying dapp using infura, 
    http://truffleframework.com/tutorials/using-infura-custom-provider

    npm install truffle-hdwallet-provider

or, use ethereum wallet to (download all blocks, i.e., make your computer a node)create an account, and then use https://faucet.rinkeby.io to get ether.
to get the private key of your account, go to https://www.myetherwallet.com/#view-wallet-info, and select your keystore in appdata/ethereum/rinkeby/keystore, and then enter your password.
[https://blog.abuiles.com/blog/2017/07/09/deploying-truffle-contracts-to-rinkeby/]
or, you can also directly import the keystorke file using metamask import account.

in truffle.js, add:
rinkeby: {
      host: "localhost",
      port: 8545,
      network_id: 4,
      from: "0xBE84Ac92C3a4827d9a3326faBee78eaD50C68aB8",
      gas: 4612388,
}

then get you public key, and:
geth --rinkeby --rpc --rpcapi db,eth,net,web3,personal --unlock="your_pubic_key"
then enter your password

in another console, 
truffle migrate --network rinkeby

Then, check your contract @ https://rinkeby.etherscan.io/address/your_contract_address_here

npm run dev
