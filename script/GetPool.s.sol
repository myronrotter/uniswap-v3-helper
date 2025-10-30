// SPDX-License-Identifier: MIT
pragma solidity ^0.8.30;

import {Script} from "forge-std/Script.sol";
import {console} from "forge-std/console.sol";
import {IUniswapV3Pool} from "@uniswap/v3-core/contracts/interfaces/IUniswapV3Pool.sol";

/// @title GetPool
/// @notice Get Uniswap V3 pool info
contract GetPool is Script {
    function run() external {
        uint256 privateKey = vm.envUint("PRIVATE_KEY");
        address poolAddress = vm.envAddress("POOL_ADDRESS");

        address user = vm.addr(privateKey);

        console.log("Get Uniswap V3 pool info");
        console.log("Pool:", poolAddress);
        console.log("Running as:", user);

        vm.startBroadcast(privateKey);

        IUniswapV3Pool pool = IUniswapV3Pool(poolAddress);

        (uint160 sqrtPriceX96, int24 tick, , , , uint8 feeProtocol, ) = pool
            .slot0();
        address factory = pool.factory();
        address token0 = pool.token0();
        address token1 = pool.token1();
        uint24 fee = pool.fee();
        uint128 liquidity = pool.liquidity();
        int24 tickSpacing = pool.tickSpacing();
        console.log("Current sqrtPriceX96:", sqrtPriceX96);
        console.log("Current tick:", tick);
        console.log("Current feeProtocol:", feeProtocol);
        console.log("Current factory:", factory);
        console.log("Current token0:", token0);
        console.log("Current token1:", token1);
        console.log("Current fee:", fee);
        console.log("Current liquidity:", liquidity);
        console.log("Current tickSpacing:", tickSpacing);

        vm.stopBroadcast();
    }
}
