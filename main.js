
// Main application interface (converted from main.cob)
const operations = require('./operations.js');
const readline = require('readline');

const rl = readline.createInterface({
    input: process.stdin,
    output: process.stdout
});

function displayMenu() {
    console.log("--------------------------------");
    console.log("Account Management System");
    console.log("1. View Balance");
    console.log("2. Credit Account");
    console.log("3. Debit Account");
    console.log("4. Exit");
    console.log("--------------------------------");
}

async function main() {
    let continueFlag = true;

    while (continueFlag) {
        displayMenu();
        const choice = await new Promise(resolve => rl.question("Enter your choice (1-4): ", resolve));

        switch (choice) {
            case '1':
                operations.viewBalance();
                break;
            case '2':
                await operations.creditAccount();
                break;
            case '3':
                await operations.debitAccount();
                break;
            case '4':
                continueFlag = false;
                break;
            default:
                console.log("Invalid choice, please select 1-4.");
        }
    }

    console.log("Exiting the program. Goodbye!");
    rl.close();
}

// Start the application
main().catch(console.error);
