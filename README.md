
# Accounting Application (Node.js Version)

A Node.js conversion of a COBOL accounting application with precise decimal arithmetic.

## Features
- View account balance
- Credit account
- Debit account (with insufficient funds check)
- Simple CLI interface
- Precise decimal calculations using decimal.js
- Comprehensive unit tests

## Requirements
- Node.js v16+
- npm

## Installation
```sh
# Clean up any existing installation
rm -rf node_modules package-lock.json

# Install dependencies
npm install
```

## Usage
```sh
npm start
```

## Testing
```sh
npm test  # Runs tests with coverage
```

## Technical Details
- **Precision Handling**: Uses decimal.js for accurate financial calculations
- **File Structure**:
  ```
  .
  ├── src/
  │   ├── data.js        # In-memory data storage
  │   ├── operations.js  # Business logic
  │   └── main.js        # CLI interface
  ├── package.json
  ├── README.md
  └── operations.test.js
  ```
- **Dependencies**:
  - decimal.js: Precise decimal arithmetic
  - readline-sync: CLI input handling
  - Jest: Testing framework

## Development
```sh
# Install additional dev dependencies
npm install --save-dev @babel/preset-env @types/jest

# Run tests with coverage
npm test -- --coverage
```

## License
ISC
