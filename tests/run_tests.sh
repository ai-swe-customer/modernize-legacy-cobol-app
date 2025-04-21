
#!/bin/bash

# Set CobolUnit path (default to ~/cobol-unit if not set)
if [ -z "$COBOLUNIT" ]; then
    COBOLUNIT=~/cobol-unit
fi

# Compile the test program
cobc -x -free tests/test_operations.cob operations.cob data.cob -I$COBOLUNIT

# Run the tests
./test_operations
echo "Test execution completed with status: $?"

# Clean up
rm -f test_operations
