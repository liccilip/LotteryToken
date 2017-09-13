# LotteryToken
BlockChain Developer - Code Challenge- Platoworks

Requirement / Problem  :

Build a simplified lottery contract using truffle framework: -

In the constructor the owner of the contract sends a SHa3 hash of the winning guess between 1 and 1'000'000 - 
In order to participate a user sends 1 ETH to the contract and gets 1 participation token. 
If the user sends more than 1 ETH the get 1 token per ETH sent 
If the user sends a fraction of ETH, the excess is returned to them 
The contract has a 'makeGuess' function which accepts a number between 1 and 1’000'000 
When makeGuess is called one token is deducted from the user's balance 
The call to makeGuess fails if the user has insufficient ballance 
The contract has a closeGame function that can only be called by the owner 
Calling the closeGame makes it impossible to send ETH to the contract or call makeGuess 
The unused tokens are not reimbursed (for simplicity) - 
A function winnerAddress will return the address of the winner once the game is closed 
Once the game is closed the winner can call getPrice to collect 50% of the ETH in the contract 
The getPrice function sends the remaining 50% of ETH to the owner of the contract

