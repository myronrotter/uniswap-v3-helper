#!/usr/bin/env node
const JSBI = require('jsbi');
const { encodeSqrtRatioX96 } = require('@uniswap/v3-sdk');

function usageAndExit() {
    console.log('Usage: node script/sqrtPriceX96.js <amount0> <amount1>');
    console.log('Example: node script/sqrtPriceX96.js 3700000000 1000000000000000000');
    process.exit(1);
}

console.log('Compute sqrtPriceX96 from token amounts.');
console.log('Note that addresses for token0 < token1.');
console.log('Note that amounts need to be scaled with respect to their decimals')

const argv = process.argv.slice(2);
if (argv.length !== 2) usageAndExit();

const [amount0Raw, amount1Raw] = argv;

try {
    let scaledAmount0 = JSBI.BigInt(amount0Raw);
    let scaledAmount1 = JSBI.BigInt(amount1Raw);

    const sqrtPriceX96 = encodeSqrtRatioX96(scaledAmount1, scaledAmount0);

    console.log('scaledAmount0 =', scaledAmount0.toString());
    console.log('scaledAmount1 =', scaledAmount1.toString());
    console.log('sqrtPriceX96 (dec) =', sqrtPriceX96.toString());
    console.log('sqrtPriceX96 (hex) =', '0x' + sqrtPriceX96.toString(16));
} catch (err) {
    console.error('Error computing sqrtPriceX96:', err && err.message ? err.message : err);
    process.exit(2);
}
