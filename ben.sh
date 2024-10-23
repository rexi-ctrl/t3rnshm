#!/bin/bash
echo "Welcome to the t3rn ALE!"

sleep 1

cd $HOME
rm -rf executor
sudo apt -q update
sudo apt -qy upgrade


EXECUTOR_URL="https://github.com/t3rn/executor-release/releases/download/v0.21.10/executor-linux-v0.21.10.tar.gz"
EXECUTOR_FILE="executor-linux-v0.21.10.tar.gz"

echo "Downloading the Executor binary from $EXECUTOR_URL..."
curl -L -o $EXECUTOR_FILE $EXECUTOR_URL

if [ $? -ne 0 ]; then
    echo "Failed to download the Executor binary. Please check your internet connection and try again."
    exit 1
fi

echo "Extracting the binary..."
tar -xzvf $EXECUTOR_FILE
rm -rf $EXECUTOR_FILE
cd executor/executor/bin

echo "Binary downloaded and extracted successfully."
echo

export NODE_ENV=testnet
export LOG_LEVEL=debug
export LOG_PRETTY=false


read -p "Enter your Private Key from Metamask: " PRIVATE_KEY_LOCAL
export PRIVATE_KEY_LOCAL=$PRIVATE_KEY_LOCAL
echo -e "\nPrivate key has been set."
echo

export ENABLED_NETWORKS='arbitrum-sepolia,base-sepolia,blast-sepolia,optimism-sepolia,l1rn'

export RPC_ENDPOINTS_ARBT='https://arb-sepolia.g.alchemy.com/v2/bBNu7asB3DxNIoXnDG8DdZ6inTn1Q99T'
export RPC_ENDPOINTS_BSSP='https://base-sepolia.g.alchemy.com/v2/bBNu7asB3DxNIoXnDG8DdZ6inTn1Q99T'
export RPC_ENDPOINTS_BLSS='https://blast-sepolia.g.alchemy.com/v2/bBNu7asB3DxNIoXnDG8DdZ6inTn1Q99T'
export RPC_ENDPOINTS_OPSP='https://opt-sepolia.g.alchemy.com/v2/bBNu7asB3DxNIoXnDG8DdZ6inTn1Q99T'


sleep 2
echo "Starting the Executor..."
./executor
rm -rf t3rn.sh
