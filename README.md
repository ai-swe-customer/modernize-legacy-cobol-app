
# Modernizing a Cobol accounting system to a Node.js application using GitHub Copilot

[Previous content remains exactly the same until the "Testing the COBOL Application" section]

## Testing the COBOL Application

The repository includes a comprehensive test suite for the COBOL accounting system.

### Running Tests

1. First, ensure you have GnuCOBOL installed:
   ```bash
   # On macOS
   brew install gnucobol
   
   # On Linux
   sudo apt-get update && sudo apt-get install gnucobol
   ```

2. Run all tests:
   ```bash
   make test
   ```

3. Run specific test categories:
   ```bash
   make test-balance    # Run balance tests only
   make test-credit     # Run credit tests only
   make test-debit      # Run debit tests only
   ```

4. Clean up compiled files:
   ```bash
   make clean
   ```

### Test Coverage
The test suite covers all operations defined in TESTPLAN.md, including balance viewing, account crediting, and account debiting scenarios.

### Test Development Guidelines

1. **Test Structure**:
   - Each test file should include `test_assertions.cpy`
   - Use standard assertion macros (ASSERT-EQUAL-VALUE, ASSERT-TRUE, etc.)
   - Include proper error handling for all CALL operations

2. **Writing Tests**:
   ```cobol
   *> Test Case: Description
   MOVE "Test Case ID" TO TEST-NAME
   CALL "ASSERT-EQUAL-VALUE" USING expected-value, actual-value, "Description"
   ```

3. **Advanced Testing**:
   ```bash
   # Run all tests with coverage
   make coverage
   ```

4. **CI/CD Integration**:
   ```yaml
   # Sample GitHub Actions configuration
   - name: Run Tests
     run: |
       sudo apt-get install gnucobol
       make test
   ```

5. **Troubleshooting**:
   - Check `tests/output/test_results.txt` for detailed results
   - Verify GnuCOBOL version with `cobc --version`

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
