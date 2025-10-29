// SPDX-License-Identifier: MIT
pragma solidity ^0.8.30;

import {Script} from "forge-std/Script.sol";
import {console} from "forge-std/console.sol";
import {IUniswapV3Pool} from "@uniswap/v3-core/contracts/interfaces/IUniswapV3Pool.sol";

/// @title CollectProtocolFees
/// @notice Collects protocol fees from all Uniswap V3 pools of a factory
contract CollectProtocolFees is Script {
    function run() external {
        uint256 factoryOwnerPrivateKey = vm.envUint("PRIVATE_KEY");
        address recipient = vm.envAddress("RECIPIENT");
        address[] memory pools = vm.envAddress("POOLS", ",");

        address factoryOwner = vm.addr(factoryOwnerPrivateKey);

        console.log("Collecting Uniswap V3 protocol fees");
        console.log("Running as:", factoryOwner);
        console.log("Recipient:", recipient);
        console.log("Number of pools:", pools.length);

        vm.startBroadcast(factoryOwnerPrivateKey);

        for (uint256 i = 0; i < pools.length; i++) {
            (uint128 amount0, uint128 amount1) = IUniswapV3Pool(pools[i])
                .collectProtocol(
                    recipient,
                    type(uint128).max,
                    type(uint128).max
                );
            console.log("Collected from pool:", pools[i]);
            console.log("   amount0:", amount0);
            console.log("   amount1:", amount1);
        }

        vm.stopBroadcast();
    }
}
