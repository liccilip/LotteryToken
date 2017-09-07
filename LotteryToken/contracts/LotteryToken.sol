pragma solidity ^0.4.11;


contract LotteryToken {
    address owner;  
    uint256 IntialSupply =100; 
    bool IsLotteryClosed=false;
    bytes32 guessinghash;      
    address winneraddress;
    uint256 costofeachtoken = 1;
	mapping (address => uint256) public balanceOf;
    bool hasWinnerClaimedLottery =false;
    string public TokenVersion ="V1";
    uint256 public LotteryEtherRaised=0; 

     //events 
     event TransferTokenEvent(address from,address to,uint256 nooftoken);
     event ExcessEtherTransferEvent(address to ,uint256 excessether);
//In the constructor the owner of the contract sends a SHa3 hash of the winning guess between 1 and 1'000'000 
    function LotteryToken(bytes32 guessinghash) {
       owner =msg.sender;
      guessinghash=guessinghash;
      balanceOf[owner]=IntialSupply;
      winneraddress = msg.sender;
    }

    modifier LotteryOpen(){
        require(IsLotteryClosed == true && balanceOf[owner]>=1);
        _;
    }

    modifier LotteryClosed(){
        require(IsLotteryClosed == false);
        _;
    }

    modifier OnlyOwner()
    {
        require(msg.sender == owner);
         _;
    }

    modifier HasEnoughBalance() {
        require(balanceOf[msg.sender]>=1);
        _;
    }

    modifier HasWinnerClaimedPrize()
    {
        require(hasWinnerClaimedLottery==false);
        _;
    }
// Close is called only by owner of contract
//The contract has a closeGame function that can only be called by the owner

function closeGame() OnlyOwner() {
    IsLotteryClosed = true;     
}

function SetIntialSupplyofToken(uint256 NoofTokens) OnlyOwner() {
IntialSupply =IntialSupply+NoofTokens;
}

function GetIntialSupplyofToken() OnlyOwner() returns(uint256) {
return IntialSupply;
}
 
 //The contract has a 'makeGuess' function which accepts a number between 1 and 1’000'000
//When makeGuess is called one token is deducted from the user's balance 
//The call to makeGuess fails if the user has insufficient ballance
//Calling the closeGame makes it impossible to send ETH to the contract or call makeGuess 

function makeGuess(uint256 guessnumber) public LotteryOpen() HasEnoughBalance() {
  balanceOf[msg.sender] -= 1; 
    bytes32 guesshash = sha3(guessnumber);
  
    if (guessinghash == guesshash) {        
      winneraddress=msg.sender;
    } 
}

//Purchase Lottery Token by Paying Ether
//In order to participate a user sends 1 ETH to the contract and gets 1 participation token. 
//If the user sends more than 1 ETH the get 1 token per ETH sent 
//If the user sends a fraction of ETH, the excess is returned to them 
function PurchaseLottery() public LotteryOpen() payable {
uint256 purchasevalue = msg.value * 1 ether;
uint256 getrealnumber = purchasevalue / 1; 
LotteryEtherRaised += getrealnumber;
transfertoken(msg.sender,purchasevalue/costofeachtoken);  
msg.sender.transfer((purchasevalue-getrealnumber) * 1 ether);
ExcessEtherTransferEvent(msg.sender,(purchasevalue-getrealnumber));
}

//A function winnerAddress will return the address of the winner once the game is closed 
//Assuming only one winner (If more than one winner is needed just add mapping)
function winnerAddress() public LotteryClosed() returns(address) {
return winneraddress;
}

function transfertoken(address receiver,uint256 nooftokens) {   
require(balanceOf[owner]>=nooftokens);     
balanceOf[owner] -= nooftokens;
balanceOf[receiver] += nooftokens;
TransferTokenEvent(owner,receiver,nooftokens);
}
//Once the game is closed the winner can call getPrice to collect 50% of the ETH in the contract 
// /The getPrice function sends the remaining 50% of ETH to the owner of the contract

function getPrice(address receiver) public LotteryClosed() HasWinnerClaimedPrize() {
if (winneraddress==receiver) {
receiver.transfer(((LotteryEtherRaised*50)/100)*1 ether);
hasWinnerClaimedLottery=true;
}

}


}
