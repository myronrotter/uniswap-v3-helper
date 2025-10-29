// SPDX-License-Identifier: MIT
pragma solidity ^0.8.30;

import {Script} from "forge-std/Script.sol";
import {console} from "forge-std/console.sol";
import {IUniswapV3Factory} from "@uniswap/v3-core/contracts/interfaces/IUniswapV3Factory.sol";
import {IUniswapV3Pool} from "@uniswap/v3-core/contracts/interfaces/IUniswapV3Pool.sol";

/// @title CreateAndInitializePool
/// @notice Creates and initializes a Uniswap V3 pool
contract CreateAndInitializePool is Script {
    function run() external {
        uint256 privateKey = vm.envUint("PRIVATE_KEY");
        address factoryAddress = vm.envAddress("FACTORY_ADDRESS");
        address token0 = vm.envAddress("TOKEN_0");
        address token1 = vm.envAddress("TOKEN_1");
        uint24 fee = uint24(vm.envUint("FEE"));
        uint160 sqrtPriceX96 = uint160(vm.envUint("SQRTPRICE_X96"));

        address user = vm.addr(privateKey);

        console.log("Creating and initializing Uniswap V3 pool");
        console.log("Running as:", user);
        console.log("Factory Address:", factoryAddress);
        console.log("Token0:", token0);
        console.log("Token1:", token1);
        console.log("Fee:", fee);
        console.log("SqrtPriceX96:", sqrtPriceX96);

        vm.startBroadcast(privateKey);

        IUniswapV3Factory factory = IUniswapV3Factory(factoryAddress);

        // Compare with PoolInitilizer
        require(token0 < token1);
        address poolAddress = factory.getPool(token0, token1, fee);

        if (poolAddress == address(0)) {
            poolAddress = factory.createPool(token0, token1, fee);
            IUniswapV3Pool(poolAddress).initialize(sqrtPriceX96);
        } else {
            (uint160 sqrtPriceX96Existing, , , , , , ) = IUniswapV3Pool(
                poolAddress
            ).slot0();
            if (sqrtPriceX96Existing == 0) {
                IUniswapV3Pool(poolAddress).initialize(sqrtPriceX96);
            }
        }

        IUniswapV3Pool actualPool = IUniswapV3Pool(poolAddress);
        (uint160 actualSqrtPriceX96, int24 tick, , , , , ) = actualPool.slot0();
        uint24 actualFee = actualPool.fee();
        console.log("Actual Pool Address:", poolAddress);
        console.log("Actual SqrtPriceX96:", actualSqrtPriceX96);
        console.log("Actual Tick:", tick);
        console.log("Actual Fee:", actualFee);

        vm.stopBroadcast();
    }
}
