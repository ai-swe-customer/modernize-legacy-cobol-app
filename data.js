
// Data persistence layer (converted from data.cob)
let balance = 1000.00; // Initial balance matching COBOL version

function read() {
    return balance;
}

function write(newBalance) {
    // Ensure we maintain 2 decimal precision
    balance = parseFloat(newBalance.toFixed(2));
    return balance;
}

module.exports = {
    read,
    write
};
