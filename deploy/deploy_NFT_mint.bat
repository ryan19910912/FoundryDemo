@echo off
cast send --rpc-url=%RPC_URL% %TEST_NFT_CONTRACT_ADDRESS% "mintTo(address)" %TEST_NFT_SEND_ADDRESS% --value %TEST_NFT_SEND_VALUE% --private-key=%PRIVATE_KEY%
exit