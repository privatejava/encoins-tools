# ENCOINS Tools
A suite of scripts and config files to run the ENCOINS backend applications.

# Installation
In order to set up all the necessary applications for the ENCOINS relay, consult the installation guide [here](https://github.com/encryptedcoins/encoins-tools/blob/main/INSTALL.md). The guide has been tested on a clean Ubuntu 22.04.3 LTS with the minimal installation option.

# Run
* Make changes to the config files if necessary.
* [Add your wallet](https://github.com/encryptedcoins/encoins-tools#cardano-wallet)
* Launch the [run.sh](https://github.com/encryptedcoins/encoins-tools/blob/main/run.sh) script or use the guide [here](https://github.com/encryptedcoins/encoins-tools/blob/main/RUN.md).
* After executing ```encoins --run```, make sure that port 3000 is accessible from the outside. You can test port accessibility [here](https://www.yougetsignal.com/tools/open-ports/).

# Notes

## cardano-node

* Use `./getNetworkConfig.sh` to download the latest default config files for the cardano-node.
* When node is synchronized and running, use `./getProtocolParameters.sh` to download the current protocol parameters in JSON format.
* To start a cardano-node with the default parameters, go to "scripts" folder and run `./node.sh`.

## cardano-wallet

* Backend wallets are stored in the "wallets" folder. Change the `mnemonic_senstence` in the "wallet-example.json" file to the seed phrase of your backend wallet and save it as "wallet.json".
* To start a cardano-wallet app, go to "scripts" folder and run `./wallet.sh`.

IMPORTANT: it is strongly recommended not to store large amounts of crypto in such backend wallets.

## Data providers
To use an external data provider, you need the corresponding token. External data providers are not yet available for the `encoins` app.

* You can get a free Blockfrost token by registering at https://blockfrost.io/. Write your token in quotes in the "blockfrost.token" file inside "mainnet/apps/encoins" folder (see "blockfrost.token.example" there).
* You can get a free Maestro token by registering at https://gomaestro.org/. Write your token in quotes in the "maestro.token" file inside "mainnet/apps/encoins" folder (see "maestro.token.example" there).


## Run with Docker 
Make sure you have `.env` file  with correct values

All the configuration related to docker are inside `./docker/config`

Make sure to edit these files 
- [wallet.json](docker/config/mainnet/relay/wallet.json) with pattern of [wallet-example.json](mainnet/wallets/wallet-example.json)
- [relay-config.json](docker/config/mainnet/relay/relay-config.json) with correct IP Address or domain for `delegation_ip`
- `docker/data` directory is accessible and this will contain all the data , db and other configs. You can change this path from env `DATA_DIR`


#### Build 
```bash
docker compose build
```

### Start
```bash
docker compose up -d
```

### Stop 
```bash
docker compose down
```

