#!/bin/bash

source .env
forge script --chain $AVALANCHE_FUJI_CHAINID script/Counter.s.sol:CounterScript --rpc-url $AVALANCHE_FUJI_RPC_URL --broadcast -vvvv