
import Decimal from 'decimal.js';
import { read, write } from './data.js';

/**
 * Gets the current account balance
 * @returns {Decimal} Current balance
 */
export function getBalance() {
    return read();
}

/**
 * Credits amount to the account
 * @param {Decimal|string|number} amount - Amount to credit
 * @returns {Decimal} New balance
 * @throws {Error} If amount is invalid
 */
export function credit(amount) {
    const amountDecimal = new Decimal(amount);
    if (amountDecimal.lte(0)) {
        throw new Error('Credit amount must be positive');
    }

    const currentBalance = read();
    const newBalance = currentBalance.plus(amountDecimal);
    write(newBalance);
    return newBalance;
}

/**
 * Debits amount from the account
 * @param {Decimal|string|number} amount - Amount to debit
 * @returns {Decimal} New balance if successful
 * @throws {Error} If amount is invalid or insufficient funds
 */
export function debit(amount) {
    const amountDecimal = new Decimal(amount);
    if (amountDecimal.lte(0)) {
        throw new Error('Debit amount must be positive');
    }

    const currentBalance = read();
    if (currentBalance.lt(amountDecimal)) {
        throw new Error('Insufficient funds for this debit');
    }

    const newBalance = currentBalance.minus(amountDecimal);
    write(newBalance);
    return newBalance;
}
