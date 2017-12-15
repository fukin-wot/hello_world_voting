pragma solidity ^0.4.18;

import "./Owned.sol";

contract Voting is Owned {

    struct Voter {
        address voterAddress;
        uint tokensBought;
        uint[] tokensUsedPerCandidate;
    }

    mapping (address => Voter) public voterInfo;
    mapping (bytes32 => uint) public votesReceived;

    uint public totalTokens;
    uint public balanceTokens;
    uint public tokenPrice;

    bytes32[] public candidateList;

    function Voting(uint tokens, uint pricePerToken, bytes32[] candidateNames) public {
        totalTokens = tokens;
        tokenPrice = pricePerToken;
        balanceTokens = tokens;
        candidateList = candidateNames;
    }

    function totalVotesFor(bytes32 candidate) view public returns (uint) {
        return votesReceived[candidate];
    }

    function voteForCandidate(bytes32 candidate, uint votesInTokens) public {
        uint index = indexOfCandidate(candidate);
        require(index != uint(-1));
        if (voterInfo[msg.sender].tokensUsedPerCandidate.length == 0) {
            for (uint i = 0; i < candidateList.length; i++) {
                voterInfo[msg.sender].tokensUsedPerCandidate.push(0);
            }
        }

        uint availableTokens = voterInfo[msg.sender].tokensBought - totalTokensUsed(voterInfo[msg.sender].tokensUsedPerCandidate);
        require(availableTokens >= votesInTokens);

        votesReceived[candidate] += votesInTokens;
        voterInfo[msg.sender].tokensUsedPerCandidate[index] += votesInTokens;
    }

    function indexOfCandidate(bytes32 candidate) view public returns (uint) {
        for (uint i = 0; i < candidateList.length; i++) {
            if (candidateList[i] == candidate) {
                return i;
            }
        }
    }

    function totalTokensUsed(uint[] _tokensUsedPerCandidate) private pure returns (uint) {
        uint totalUsedTokens = 0;
        for (uint i = 0; i < _tokensUsedPerCandidate.length; i++) {
            totalUsedTokens += _tokensUsedPerCandidate[i];
        }
        return totalUsedTokens;
  }

  function buy() payable public returns (uint) {
      uint tokensToBuy = msg.value / tokenPrice;
      require(tokensToBuy <= balanceTokens);
      voterInfo[msg.sender].voterAddress = msg.sender;
      voterInfo[msg.sender].tokensBought += tokensToBuy;
      balanceTokens -= tokensToBuy;
      return tokensToBuy;
  }

  function tokenSold() view public returns (uint) {
      return totalTokens - balanceTokens;
  }

  function voterDetails(address user) view public returns (uint, uint[]) {
      return (voterInfo[user].tokensBought, voterInfo[user].tokensUsedPerCandidate);
  }

  function transferTo(address account) public onlyowner {
      account.transfer(this.balance);
  }

  function allCandidates() view public returns (bytes32[]) {
      return candidateList;
  }

}