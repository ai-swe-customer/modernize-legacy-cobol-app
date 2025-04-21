
// Business logic layer (converted from operations.cob)
const data = require('./data.js');
const readline = require('readline');

const rl = readline.createInterface({
    input: process.stdin,
    output: process.stdout
});

function viewBalance() {
    const balance = data.read();
    console.log(`Current balance: ${balance.toFixed(2)}`);
    return balance;
}

async function creditAccount() {
    const amount = parseFloat(await new Promise(resolve => rl.question('Enter credit amount: ', resolve)));
    if (isNaN(amount) || amount <= 0) {
        console.log('Invalid amount');
        return;
    }

    const currentBalance = data.read();
    const newBalance = currentBalance + amount;
    data.write(newBalance);
    console.log(`Amount credited. New balance: ${newBalance.toFixed(2)}`);
    return newBalance;
}

async function debitAccount() {
    const amount = parseFloat(await new Promise(resolve => rl.question('Enter debit amount: ', resolve)));
    if (isNaN(amount) || amount <= 0) {
        console.log('Invalid amount');
        return;
    }

    const currentBalance = data.read();
    if (currentBalance >= amount) {
        const newBalance = currentBalance - amount;
        data.write(newBalance);
        console.log(`Amount debited. New balance: ${newBalance.toFixed(2)}`);
        return newBalance;
    } else {
        console.log('Insufficient funds for this debit.');
        return currentBalance;
    }
}

module.exports = {
    viewBalance,
    creditAccount,
    debitAccount
};
