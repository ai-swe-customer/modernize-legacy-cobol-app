
import { getBalance, credit, debit } from './operations.js';
import Decimal from 'decimal.js';

describe('Accounting Operations', () => {
    beforeEach(() => {
        // Reset balance before each test
        const { write } = require('../src/data.js');
        write(new Decimal('1000.00'));
    });

    test('should get initial balance', () => {
        const balance = getBalance();
        expect(balance.toString()).toBe('1000.00');
    });

    test('should credit account correctly', () => {
        const newBalance = credit('500.50');
        expect(newBalance.toString()).toBe('1500.50');
        expect(getBalance().toString()).toBe('1500.50');
    });

    test('should debit account correctly', () => {
        const newBalance = debit('200.25');
        expect(newBalance.toString()).toBe('799.75');
        expect(getBalance().toString()).toBe('799.75');
    });

    test('should reject invalid credit amount', () => {
        expect(() => credit('-100')).toThrow('Credit amount must be positive');
        expect(() => credit('0')).toThrow('Credit amount must be positive');
    });

    test('should reject invalid debit amount', () => {
        expect(() => debit('-100')).toThrow('Debit amount must be positive');
        expect(() => debit('0')).toThrow('Debit amount must be positive');
    });

    test('should reject debit with insufficient funds', () => {
        expect(() => debit('2000')).toThrow('Insufficient funds for this debit');
    });
});
