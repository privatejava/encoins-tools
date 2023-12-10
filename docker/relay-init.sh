#!/usr/bin/env bash
PATH=~/.local/bin:$PATH
LD_LIBRARY_PATH=/usr/local/lib:$LD_LIBRARY_PATH
ldconfig

network_dir="testnet-preprod"
if [ "$NETWORK" == "mainnet" ]; then
    echo "Using mainnet"
    network_dir="mainnet"
else
    echo "Using preprod"
fi

cd /app/$network_dir/apps/encoins

curl -H "content-type: application/json" -XPOST -d @/wallets/wallet.json localhost:8090/v2/wallets
encoins --run
