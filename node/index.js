const fs = require('fs');
const path = require('path');
const solc = require('solc');
const Web3 = require('Web3');
const HDWalletProvider = require('@truffle/hdwallet-provider');
const mnemonic = process.env.MNEMONIC
const providerOrUrl = `https://eth-goerli.g.alchemy.com/v2/${process.env.WEB3_ALCHEMY_PROJECT_ID}`

const provider = new HDWalletProvider({ mnemonic, providerOrUrl });
const web3 = new Web3(provider);

const content = fs.readFileSync('../contracts/Tara.sol', 'utf8');

const input = {
    language: 'Solidity',
    sources: {
      'Tara.sol': { content }
    },
    settings: {
      outputSelection: { '*': { '*': ['*'] } }
    }
  };

  async function deploy (){

    const account = await web3.eth.getAccounts();
    const {contracts} = JSON.parse(
      solc.compile(JSON.stringify(input))
    );
    const contract = contracts['Tara.sol'].MyContract;

    const abi = contract.abi;
    const bytecode = contract.evm.bytecode.object;
    const { _address } = await new web3.eth.Contract(abi)
      .deploy({ data: bytecode })
      .send({from: account, gas: 100000 });
    console.log("Contract Address =>", _address);
  };
  deploy();
