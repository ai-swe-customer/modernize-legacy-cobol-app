
# COBOL Accounting Application Tests

## Test Setup

1. Install GnuCOBOL 3.1 or later:
```bash
# For MacOS
brew install gnucobol

# For Linux
sudo apt-get update && sudo apt-get install gnucobol
```

2. Verify installation:
```bash
cobc --version
```

## Running Tests

### Run All Tests
```bash
cobc -x -j tests/test_*.cob operations.cob
```

### Run Specific Tests
```bash
# Test TOTAL operation
cobc -x -j tests/test_total.cob operations.cob

# Test CREDIT operation 
cobc -x -j tests/test_credit.cob operations.cob

# Test DEBIT operation
cobc -x -j tests/test_debit.cob operations.cob
```

## Test Cases

### TOTAL Operation
- Verifies correct display of current balance
- Uses mocked DataProgram to return known balance

### CREDIT Operation
1. Valid amount:
   - Adds specified amount to balance
2. Zero amount:
   - Verifies balance remains unchanged

### DEBIT Operation  
1. Valid amount (<= balance):
   - Subtracts amount from balance
2. Amount > balance:
   - Verifies "Insufficient funds" message
3. Zero amount:
   - Verifies balance remains unchanged

## Expected Output
Successful tests will display:
```
TEST PASSED: [operation name]
```

Failed tests will show:
```
TEST FAILED: [operation name]
Expected: [expected value]
Actual: [actual value]
```
