npm install ethereumjs-testrpc web3@0.20.1
write contract file Voting.sol
npm install solc

(in another terminal)
testrpc

(node console)
node
Web3 = require('web3')
web3 = new Web3(new Web3.providers.HttpProvider('http://localhost:8545'));

(for accounts)
web.eth.accounts

code = fs.readFileSync('Voting.sol').toString()
solc = require('solc')
(compiling)
compiledCode = solc.compile(code)


abiDefinition = JSON.parse(compiledCode.contracts[':Voting'].interface)
VotingContract = web3.eth.contract(abiDefinition)
byteCode = compiledCode.contracts[':Voting'].bytecode
deployedContract = VotingContract.new(['Tom','Dick','Harry'],{data: byteCode, from: web3.eth.accounts[0], gas: 4700000})
deployedContract.address
contractInstance = VotingContract.at(deployedContract.address)


contractInstance.totalVotesFor.call('Tom').toLocaleString()
'0'

contractInstance.voteForCandidate('Tom', {from: web3.eth.accounts[0]})

contractInstance.totalVotesFor.call('Rama').toLocaleString()
'1'

then write the html and js files