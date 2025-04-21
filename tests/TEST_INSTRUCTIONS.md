
# Testing Instructions

## Working Tests
- Total operation test: `cobc -x -j tests/test_total.cob tests/mock_dataprogram.cob operations.cob`

## Tests Needing Manual Verification
1. Credit operation:
```bash
cobc -x main.cob operations.cob data.cob
./main
# Manually verify credit operations
```

2. Debit operation:
```bash
cobc -x main.cob operations.cob data.cob
./main
# Manually verify debit operations including insufficient funds
```

## Future Work Needed
- Implement proper test isolation for credit/debit operations
- Add automated input simulation
- Improve mock data verification
