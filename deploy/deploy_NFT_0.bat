@echo off
forge create NFTDemo --rpc-url=%RPC_URL% --private-key=%PRIVATE_KEY% --constructor-args %TEST_NFT_NAME% %TEST_NFT_SYMBOL% %TEST_NFT_BASE_URI% %TEST_NFT_UNREVEALED_URI%;
exit