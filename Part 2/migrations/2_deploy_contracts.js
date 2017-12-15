var Voting = artifacts.require('./Voting.sol');

module.exports = function (deployer) {
  deployer.deploy(Voting, ['sacros', 'sacra', 'anct'], { gas: 6700000 });
};