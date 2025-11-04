// SPDX-License-Identifier: MIT
pragma solidity ^0.8.30;

import {Script} from "forge-std/Script.sol";
import {console} from "forge-std/console.sol";

/// @title AddressOrder
/// @notice Get order of addresses
contract AddressOrder is Script {
    function run() external view {
        address token0 = vm.envAddress("TOKEN_0_ADDRESS");
        address token1 = vm.envAddress("TOKEN_1_ADDRESS");

        console.log("Get order of addresses");
        console.log("Token0:", token0);
        console.log("Token1:", token1);

        if (token0 < token1) {
            console.log("Order: token0 %s < token1 %s", token0, token1);
        } else if (token0 > token1) {
            console.log("Order: token0 %s > token1 %s", token0, token1);
        } else {
            console.log("Error: token0 %s == token1 %s", token0, token1);
        }
    }
}
