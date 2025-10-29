// SPDX-License-Identifier: MIT
pragma solidity ^0.8.30;

import {Script} from "forge-std/Script.sol";
import {console} from "forge-std/console.sol";
import {IUniswapV3Factory} from "@uniswap/v3-core/contracts/interfaces/IUniswapV3Factory.sol";

contract EnableFee is Script {
    function run() external {
        uint256 factoryOwnerPrivateKey = vm.envUint("PRIVATE_KEY");
        address factoryAddress = vm.envAddress("FACTORY_ADDRESS");
        uint24 fee = uint24(vm.envUint("FEE"));
        int24 tickSpacing = int24(vm.envInt("TICK_SPACING"));

        address factoryOwner = vm.addr(factoryOwnerPrivateKey);

        console.log("Enabling fee tier");
        console.log("Running as:", factoryOwner);
        console.log("Factory Address:", factoryAddress);
        console.log("Fee:", fee);
        console.log("Tick Spacing:", tickSpacing);

        vm.startBroadcast(factoryOwnerPrivateKey);

        IUniswapV3Factory factory = IUniswapV3Factory(factoryAddress);

        factory.enableFeeAmount(fee, tickSpacing);

        int24 actualTickSpacing = factory.feeAmountTickSpacing(fee);

        console.log("Actual Tick Spacing:", actualTickSpacing);

        vm.stopBroadcast();
    }
}
