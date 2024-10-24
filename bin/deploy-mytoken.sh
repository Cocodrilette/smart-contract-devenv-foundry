#!/bin/bash

source .env
forge script --chain $AVALANCHE_FUJI_CHAINID script/MyToken.s.sol:MyTokenScript --rpc-url $AVALANCHE_FUJI_RPC_URL --broadcast -vvvv