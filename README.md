# uniswap-v3-helper

A set of Uniswap V3 helper contracts and scripts.

## Usage

```sh
# Set protocol fees for pool
PRIVATE_KEY=0xabc123... \
POOL_ADDRESS=0xPoolAddress \
FEE_PROTOCOL_0=6 \
FEE_PROTOCOL_1=10 \
forge script script/SetProtocolFee.s.sol \
  --rpc-url https://your-rpc.io/ \
  --broadcast

# Collect protocol fees from pools
PRIVATE_KEY=0xabc123... \
RECIPIENT=0xTreasuryAddress \
POOLS=0x1111...,0x2222...,0x3333... \
forge script script/CollectProtocolFees.s.sol \
  --rpc-url https://your-rpc.io/ \
  --broadcast

# Create and init pool
PRIVATE_KEY=0xabc123... \
FACTORY_ADDRESS=0xFactoryAddress \
TOKEN_0=0x1111... \
TOKEN_1=0x2222... \
FEE=3000 \
SQRTPRICE_X96=79228162514264337593543950336 \
forge script script/CreateAndInitializePool.s.sol \
  --rpc-url https://your-rpc.io/ \
  --broadcast

# Enable fee tier
PRIVATE_KEY=0xabc123... \
FACTORY_ADDRESS=0xFactoryAddress \
FEE=3000 \
TICK_SPACING=200 \
forge script script/EnableFee.s.sol \
  --rpc-url https://your-rpc.io/ \
  --broadcast

# Get pool info
POOL_ADDRESS=0xFactoryAddress \
forge script script/GetPool.s.sol \
  --rpc-url https://your-rpc.io/

# Get order of addresses
TOKEN_0_ADDRESS=0xtoken0 \
TOKEN_1_ADDRESS=0xtoken1 \
forge script script/AddressOrder.s.sol

# Compute sqrtPriceX6 for initing pool
# Note that amounts need to be scaled and token0 < token1
pnpm run compute:sqrtPriceX96 <amount0> <amount1>

# Compute price from sqrtPriceX96
# Note that the price is as token0 per 1 token1.
pnpm run compute:sqrtPriceX96 <amount0> <amount1>
```
