#!/usr/bin/env node

// Compute token0 per 1 token1 from sqrtPriceX96
// dec0 = token0 decimals, dec1 = token1 decimals
// Always returns a string with 2 decimal places as precision
function token0Per1Token1(sqrtPriceX96, dec0, dec1) {
    const s = BigInt(sqrtPriceX96);
    const numerator = (2n ** 192n) * (10n ** BigInt(dec1 - dec0));
    const denom = s * s;

    // Get integer result scaled to 2 decimals
    const scaled = (numerator * 100n) / denom; // *100 for 2 decimal places
    const intPart = scaled / 100n;
    const fracPart = (scaled % 100n).toString().padStart(2, '0');

    return `${intPart}.${fracPart}`;
}

function usageAndExit() {
    console.log('Usage: node script/price.js <sqrtPriceX96> <dec0> <dec1>');
    console.log('Example: node script/price.js 1302502968340932705984594224758092 6 18');
    process.exit(1);
}

console.log('Compute price as token0 per 1 token1 from sqrtPriceX96.');
console.log('Note that decimal precision of returned value is 2.');

const argv = process.argv.slice(2);
if (argv.length !== 3) usageAndExit();

const [sqrtPriceX96, dec0Raw, dec1Raw] = argv;

const dec0 = Number(dec0Raw);
const dec1 = Number(dec1Raw);

console.log(token0Per1Token1(sqrtPriceX96, dec0, dec1));
