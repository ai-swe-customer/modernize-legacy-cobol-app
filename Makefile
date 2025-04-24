
# Makefile for COBOL Accounting Application Tests
COBC = cobc
COBFLAGS = -x -I.

# List of test programs
TESTS = tests/test_view_balance.cob \
        tests/test_credit_valid.cob \
        tests/test_credit_zero.cob \
        tests/test_debit_valid.cob \
        tests/test_debit_zero.cob \
        tests/test_debit_overdraw.cob \
        tests/test_exit.cob

# Main program dependencies
MAIN_SRC = operations.cob data.cob

.PHONY: all test clean

all: test

test: $(TESTS:.cob=.exe)
	@echo "Running all tests..."
	@for test in $(TESTS:.cob=.exe); do \
		echo "Running $$test..."; \
		./$$test; \
	done

%.exe: %.cob $(MAIN_SRC)
	$(COBC) $(COBFLAGS) $< $(MAIN_SRC) -o $@

clean:
	rm -f $(TESTS:.cob=.exe) *.o
