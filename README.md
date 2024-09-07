# 🚩 Challenge 2: 🏵 Token Vendor 🤖

<https://speedrunethereum.com/challenge/token-vendor>

🏵 Create YourToken.sol smart contract that inherits the ERC20 token standard from OpenZeppelin. Set your token to _mint() 1000 (* 10 ** 18) tokens to the msg.sender. Then create a Vendor.sol contract that sells your token using a payable buyTokens() function.

🎛 Edit the frontend that invites the user to input an amount of tokens they want to buy. We'll display a preview of the amount of ETH it will cost with a confirm button.

🔍 It will be important to verify your token's source code in the block explorer after you deploy. Supporters will want to be sure that it has a fixed supply and you can't just mint more.

🌟 The final deliverable is an app that lets users purchase your ERC20 token, transfer it, and sell it back to the vendor. Deploy your contracts on your public chain of choice and then yarn vercel your app to a public web server. 
