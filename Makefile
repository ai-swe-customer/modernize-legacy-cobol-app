
# Makefile for COBOL Accounting Application Tests

COBOL = cobc
CFLAGS = -x -free -I./

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

# Test targets
test: tests/test_runner
	./tests/test_runner

test-balance: tests/balance_tests
	./tests/balance_tests

test-credit: tests/credit_tests
	./tests/credit_tests

test-debit: tests/debit_tests
	./tests/debit_tests

clean:
	rm -f *.o
	rm -f tests/*.o
	rm -f tests/balance_tests
	rm -f tests/credit_tests
	rm -f tests/debit_tests
	rm -f tests/test_runner

.PHONY: all test test-balance test-credit test-debit clean
