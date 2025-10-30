#!/usr/bin/env node
const JSBI = require('jsbi');
const { encodeSqrtRatioX96 } = require('@uniswap/v3-sdk');

function usageAndExit() {
    console.log('Usage: node script/sqrtPriceX96-cli.js <scaled> <decimals0> <decimals1> <amount0> <amount1>');
    console.log('Example: node script/sqrtPriceX96-cli.js false 18 6 1 3000');
    process.exit(1);
}

const argv = process.argv.slice(2);
if (argv.length !== 5) usageAndExit();

const [scaledRaw, decimals0Raw, decimals1Raw, amount0Raw, amount1Raw] = argv;
const scaled = scaledRaw.toLowerCase() === 'true';
const decimals0 = Number(decimals0Raw);
const decimals1 = Number(decimals1Raw);
if (!Number.isInteger(decimals0) || !Number.isInteger(decimals1)) {
    console.error('decimals must be integers');
    usageAndExit();
}

// amount strings are interpreted as integer token amounts in whole tokens (not smallest unit),
// caller may pass already-scaled numbers if desired.
const amount0 = amount0Raw;
const amount1 = amount1Raw;

try {
    let scaledAmount0 = JSBI.BigInt(amount0);
    let scaledAmount1 = JSBI.BigInt(amount1);
    if (!scaled) {
        const scale0 = JSBI.exponentiate(JSBI.BigInt(10), JSBI.BigInt(decimals0));
        const scale1 = JSBI.exponentiate(JSBI.BigInt(10), JSBI.BigInt(decimals1));

        scaledAmount0 = JSBI.multiply(JSBI.BigInt(amount0), scale0);
        scaledAmount1 = JSBI.multiply(JSBI.BigInt(amount1), scale1);
    }

    const sqrtPriceX96 = encodeSqrtRatioX96(scaledAmount1, scaledAmount0);

    console.log('decimals0 =', decimals0, 'decimals1 =', decimals1);
    console.log('amount0 =', amount0, 'amount1 =', amount1);
    console.log('scaledAmount0 =', scaledAmount0.toString());
    console.log('scaledAmount1 =', scaledAmount1.toString());
    console.log('sqrtPriceX96 (dec) =', sqrtPriceX96.toString());
    console.log('sqrtPriceX96 (hex) =', '0x' + sqrtPriceX96.toString(16));
} catch (err) {
    console.error('Error computing sqrtPriceX96:', err && err.message ? err.message : err);
    process.exit(2);
}
