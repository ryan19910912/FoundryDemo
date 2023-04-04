@echo off
forge create NFTDemo --rpc-url=%RPC_URL% --private-key=%PRIVATE_KEY% --constructor-args %NFT_NAME% %NFT_SYMBOL%;
exit