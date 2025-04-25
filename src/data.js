
import Decimal from 'decimal.js';

// Initialize balance to 1000.00 as in COBOL version
let balance = new Decimal('1000.00');

/**
 * Reads the current balance
 * @returns {Decimal} Current balance
 */
export function read() {
    return balance;
}

/**
 * Writes a new balance value
 * @param {Decimal} newBalance - The new balance value
 */
export function write(newBalance) {
    balance = newBalance;
}
