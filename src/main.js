
import readlineSync from 'readline-sync';
import { getBalance, credit, debit } from './operations.js';

function displayMenu() {
    console.log('--------------------------------');
    console.log('Account Management System');
    console.log('1. View Balance');
    console.log('2. Credit Account');
    console.log('3. Debit Account');
    console.log('4. Exit');
    console.log('--------------------------------');
}

function getAmountInput(prompt) {
    while (true) {
        const input = readlineSync.question(prompt);
        try {
            const amount = new Decimal(input);
            if (amount.lte(0)) {
                console.log('Amount must be positive. Please try again.');
                continue;
            }
            return amount;
        } catch (error) {
            console.log('Invalid amount. Please enter a valid number.');
        }
    }
}

function main() {
    console.log('Welcome to the Accounting System (Node.js version)\n');

    while (true) {
        displayMenu();
        const choice = readlineSync.question('Enter your choice (1-4): ');

        try {
            switch (choice) {
                case '1':
                    console.log(`\nCurrent balance: ${getBalance().toFixed(2)}\n`);
                    break;
                case '2': {
                    const amount = getAmountInput('\nEnter credit amount: ');
                    const newBalance = credit(amount);
                    console.log(`\nAmount credited. New balance: ${newBalance.toFixed(2)}\n`);
                    break;
                }
                case '3': {
                    const amount = getAmountInput('\nEnter debit amount: ');
                    try {
                        const newBalance = debit(amount);
                        console.log(`\nAmount debited. New balance: ${newBalance.toFixed(2)}\n`);
                    } catch (error) {
                        console.log(`\nError: ${error.message}\n`);
                    }
                    break;
                }
                case '4':
                    console.log('\nExiting the program. Goodbye!\n');
                    return;
                default:
                    console.log('\nInvalid choice, please select 1-4.\n');
            }
        } catch (error) {
            console.log(`\nError: ${error.message}\n`);
        }
    }
}

main();
