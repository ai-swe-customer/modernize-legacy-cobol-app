
# COBOL Accounting Application - Testing Guide

## Prerequisites
- GnuCOBOL 3.1 or later
- GNU Make

## Installation
1. Install GnuCOBOL:
   - Ubuntu/Debian: `sudo apt-get install gnucobol`
   - RHEL/CentOS: `sudo yum install gnucobol`
   - macOS: `brew install gnucobol`

## Running Tests
1. Build and run all tests:
   ```bash
   make test
   ```

2. Run individual tests:
   ```bash
   cobc -x -free tests/test_view_balance.cob operations.cob data.cob
   ./test_view_balance
   ```

## Test Cases

### Balance Operations
1. **TC-1.1: View Current Balance**
   - Verifies the initial balance display (1000.00)

### Credit Operations
2. **TC-2.1: Credit Account with Valid Amount**
   - Tests crediting 100.00 to the account
   - Verifies new balance (1100.00)

3. **TC-2.2: Credit Account with Zero Amount**
   - Tests attempting to credit 0.00
   - Verifies balance remains unchanged (1000.00)
   - Verifies error message

### Debit Operations
4. **TC-3.1: Debit Account with Valid Amount**
   - Tests debiting 50.00 from the account
   - Verifies new balance (950.00)

5. **TC-3.2: Debit Account with Amount > Balance**
   - Tests attempting to debit 2000.00
   - Verifies balance remains unchanged (1000.00)
   - Verifies "Insufficient funds" message

6. **TC-3.3: Debit Account with Zero Amount**
   - Tests attempting to debit 0.00
   - Verifies balance remains unchanged (1000.00)
   - Verifies error message

### Application Flow
7. **TC-4.1: Exit the Application**
   - Tests application exit functionality
   - Verifies exit message is displayed
   - Confirms application terminates properly

## Adding New Tests
1. Create new .cob file in tests/ directory
2. Include balancews.cpy and balancels.cpy
3. Follow test template:
   - Initialize balance
   - Set test parameters
   - Call Operations
   - Verify results
4. Add test to Makefile TESTS list

## Expected Output
Successful test runs will display:
- Test case name
- Expected values
- "Test completed" message

## Troubleshooting
- If tests fail, check:
  - GnuCOBOL is properly installed (`cobc --version`)
  - All source files are in place
  - No syntax errors in test files
