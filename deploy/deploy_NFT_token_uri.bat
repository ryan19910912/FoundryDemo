@echo off
cast call --rpc-url=%RPC_URL% %TEST_NFT_CONTRACT_ADDRESS% "tokenURI(uint256)(string)" %TEST_NFT_TOKEN_ID% --private-key=%PRIVATE_KEY%
exit