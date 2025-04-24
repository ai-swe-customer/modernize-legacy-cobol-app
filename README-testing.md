
# Testing the COBOL Accounting Application

## Requirements
- GnuCOBOL 3.0 or higher (tested with 3.1.2)
- GNU Make

## Running Tests
To run all tests:
```bash
make test
```

This will:
1. Compile all source files and test programs
2. Execute each test program
3. Report test results

## Test Structure
The test suite consists of individual COBOL programs in the `tests/` directory, each testing a specific functionality:

- `test_view_balance.cob`: Tests viewing current balance (TC-1.1)
- `test_credit_valid.cob`: Tests valid credit operations (TC-2.1)
- `test_credit_zero.cob`: Tests zero amount credit (TC-2.2)
- `test_debit_valid.cob`: Tests valid debit operations (TC-3.1)
- `test_debit_insufficient.cob`: Tests insufficient funds debit (TC-3.2)
- `test_debit_zero.cob`: Tests zero amount debit (TC-3.3)
- `test_exit_application.cob`: Tests application exit (TC-4.1)

## Initial State
All tests assume:
- Initial balance of 1000.00
- data.cob module provides storage operations
- operations.cob implements the business logic

## Module Naming
The system uses these module names consistently:
- `data` (data.cob) - provides storage operations
- `Operations` (operations.cob) - implements business logic
- `test_exit_application.cob`: Tests application exit (TC-4.1)

All tests assume an initial balance of 1000.00 unless otherwise specified.

## Adding New Tests
To add a new test:
1. Create a new `.cob` file in the `tests/` directory
2. Follow the pattern of existing tests:
   - Set up initial conditions
   - Call the operation being tested
   - Verify expected results
   - Return 0 for success, 1 for failure
3. Add the new test to the `TESTS` variable in the Makefile

## Test Execution Flow
1. Each test program:
   - Sets up initial balance (through DataProgram)
   - Calls the operation being tested
   - Verifies the result
2. The Makefile:
   - Compiles all dependencies
   - Runs each test program sequentially
   - Stops on first failure (exit code 1)

## Troubleshooting
If tests fail:
1. Verify GnuCOBOL is installed (`cobc --version`)
2. Check test output for specific failure details
3. Examine the test program and operations.cob for discrepancies
