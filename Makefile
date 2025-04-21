
# Makefile for COBOL Accounting Application Tests
# Version: 1.2
# Requires:
# - GnuCOBOL 3.0+ (https://gnucobol.sourceforge.io)
# - GNU Make 4.0+ 
# Optional:
# - lcov for coverage reports

COBOL = cobc
CFLAGS = -x -free -I./
TESTFLAGS = -j4  # Run tests in parallel with 4 jobs

all: test

# Main program compilation
operations.o: operations.cob
	$(COBOL) $(CFLAGS) -c $<

# Test programs compilation
tests/balance_tests: tests/operations/balance_tests.cob operations.o
	$(COBOL) $(CFLAGS) -o $@ $^

tests/credit_tests: tests/operations/credit_tests.cob operations.o
	$(COBOL) $(CFLAGS) -o $@ $^

tests/debit_tests: tests/operations/debit_tests.cob operations.o
	$(COBOL) $(CFLAGS) -o $@ $^

tests/test_runner: tests/test_runner.cob operations.o
	$(COBOL) $(CFLAGS) -o $@ $^

# Create output directory
tests/output:
	mkdir -p tests/output

# Test Execution
test: tests/test_runner tests/output
	$(MAKE) $(TESTFLAGS) test-balance test-credit test-debit
	./tests/test_runner > tests/output/test_results.txt

test-balance: tests/balance_tests
	./tests/balance_tests > tests/output/balance_results.txt

test-credit: tests/credit_tests
	./tests/credit_tests > tests/output/credit_results.txt

test-debit: tests/debit_tests
	./tests/debit_tests > tests/output/debit_results.txt

# Coverage
coverage: CFLAGS += -fprofile-arcs -ftest-coverage
coverage: clean test
	lcov --capture --directory . --output-file tests/output/coverage.info
	genhtml tests/output/coverage.info --output-directory tests/output/coverage

# Development
setup:
	@echo "Installing dependencies..."
	@echo "- On Debian/Ubuntu: sudo apt-get install gnucobol make lcov"
	@echo "- On macOS: brew install gnucobol lcov"

version:
	@echo "Test Suite Version 1.2"

# Cleanup
clean:
	rm -f *.o
	rm -f tests/*.o
	rm -f tests/balance_tests
	rm -f tests/credit_tests
	rm -f tests/debit_tests
	rm -f tests/test_runner
	rm -rf tests/output

.PHONY: all test test-balance test-credit test-debit coverage setup version clean
