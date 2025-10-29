const JSBI = require('jsbi');
const { encodeSqrtRatioX96 } = require('@uniswap/v3-sdk');

// Minimal SDK example: compute sqrtPriceX96 for a single example
// Example: token0 decimals = 18, token1 decimals = 6, amount0 = 1, amount1 = 3000
const decimals0 = 18;
const decimals1 = 6;
const amount0 = '1';
const amount1 = '3000';

// Scale amounts by decimals: scaled = amount * 10^decimals
const scale0 = JSBI.exponentiate(JSBI.BigInt(10), JSBI.BigInt(decimals0));
const scale1 = JSBI.exponentiate(JSBI.BigInt(10), JSBI.BigInt(decimals1));

const scaledAmount0 = JSBI.multiply(JSBI.BigInt(amount0), scale0); // amount0 * 10^decimals0
const scaledAmount1 = JSBI.multiply(JSBI.BigInt(amount1), scale1); // amount1 * 10^decimals1

// encodeSqrtRatioX96(amount1, amount0)
const sqrtPriceX96 = encodeSqrtRatioX96(scaledAmount1, scaledAmount0);

console.log('Example: amount0 =', amount0, 'decimals0 =', decimals0);
console.log('         amount1 =', amount1, 'decimals1 =', decimals1);
console.log('scaledAmount0 =', scaledAmount0.toString());
console.log('scaledAmount1 =', scaledAmount1.toString());
console.log('sqrtPriceX96 (dec) =', sqrtPriceX96.toString());
console.log('sqrtPriceX96 (hex) =', '0x' + sqrtPriceX96.toString(16));

