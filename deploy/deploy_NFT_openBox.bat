@echo off
cast send --rpc-url=%RPC_URL% %TEST_NFT_CONTRACT_ADDRESS% "openBox()" --private-key=%PRIVATE_KEY%
exit