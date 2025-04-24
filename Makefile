
# Makefile for COBOL Accounting Application Tests
COBC = cobc
COBFLAGS = -x -free -I.
SRC = operations.cob data.cob
TESTS = tests/test_view_balance.cob tests/test_credit_valid.cob \
        tests/test_credit_zero.cob tests/test_debit_valid.cob \
        tests/test_debit_insufficient.cob tests/test_debit_zero.cob \
        tests/test_exit_application.cob

all: compile test

compile: $(SRC:.cob=.o) $(TESTS:.cob=.o)

%.o: %.cob
	$(COBC) $(COBFLAGS) -c $< -o $@

test: compile
	@echo "Running all tests..."
	@for test in $(TESTS:.cob=); do \
		echo "Running $$test..."; \
		./$$test || exit 1; \
	done
	@echo "All tests passed!"

clean:
	rm -f *.o tests/*.o $(SRC:.cob=) $(TESTS:.cob=)

.PHONY: all compile test clean
