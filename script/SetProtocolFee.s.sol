// SPDX-License-Identifier: MIT
pragma solidity ^0.8.30;

import {Script} from "forge-std/Script.sol";
import {console} from "forge-std/console.sol";
import {IUniswapV3Pool} from "@uniswap/v3-core/contracts/interfaces/IUniswapV3Pool.sol";

/// @title SetProtocolFee
/// @notice Foundry script to set protocol fees for a Uniswap V3 pool
contract SetProtocolFee is Script {
    function run() external {
        uint256 factoryOwnerPrivateKey = vm.envUint("PRIVATE_KEY");
        address poolAddress = vm.envAddress("POOL_ADDRESS");
        uint8 feeProtocol0 = uint8(vm.envUint("FEE_PROTOCOL_0"));
        uint8 feeProtocol1 = uint8(vm.envUint("FEE_PROTOCOL_1"));

        address factoryOwner = vm.addr(factoryOwnerPrivateKey);

        console.log("Setting Uniswap V3 protocol fee");
        console.log("Pool:", poolAddress);
        console.log("Running as:", factoryOwner);
        console.log("Fee Protocol Token0:", feeProtocol0);
        console.log("Fee Protocol Token1:", feeProtocol1);

        vm.startBroadcast(factoryOwnerPrivateKey);

        IUniswapV3Pool pool = IUniswapV3Pool(poolAddress);
        pool.setFeeProtocol(feeProtocol0, feeProtocol1);

        (, , , , , uint8 feeProtocol, ) = pool.slot0();
        console.log("Actual Fee Protocol Token0:", feeProtocol % 16);
        console.log("Actual Fee Protocol Token1:", feeProtocol >> 4);

        vm.stopBroadcast();
    }
}
