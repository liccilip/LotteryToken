pragma solidity ^0.4.2;

import "truffle/Assert.sol";
import "truffle/DeployedAddresses.sol";
import "../contracts/LotteryToken.sol";

var account_one = "0x1234..."; // an address

contract TestLotteryToken {
  uint public initialBalance = 6 ether;
function  testIntialLotteryToken() {
LotteryToken lotterytoken = new LotteryToken(sha3(1));
bytes32 expected = sha3(1);
Assert.equal(lotterytoken.getWinnerhash(), expected, "Guesssed SHA Matches");
}

function testBalanceAfterPay() {
LotteryToken lotterytoken =LotteryToken(DeployedAddresses.LotteryToken());
lotterytoken.PurchaseLottery(2,{from:account_one});
}

}