
       IDENTIFICATION DIVISION.
       PROGRAM-ID. DebitTests.
      *> Test cases for account debiting (TC-3.1, TC-3.2, TC-3.3)
      *> Requires GnuCOBOL 3.0 or later

       DATA DIVISION.
       COPY "../test_assertions.cpy".
       COPY "operations.cpy".

       WORKING-STORAGE SECTION.
      *> Test Configuration
       01 TEST-INIT-BALANCE  PIC 9(6)V99 VALUE 1000.00.
       01 TEST-RESULT.
          05 PASS-COUNT      PIC 9(2) VALUE 0.
          05 FAIL-COUNT      PIC 9(2) VALUE 0.
          05 TOTAL-COUNT     PIC 9(2) VALUE 3.

      *> Test Cases
       01 TEST-CASES.
          05 FILLER.
             10 TEST-NAME    PIC X(20) VALUE "Valid Debit".
             10 TEST-AMOUNT  PIC 9(6)V99 VALUE 50.00.
             10 EXP-RESULT   PIC 9(6)V99 VALUE 950.00.
          05 FILLER.
             10 TEST-NAME    PIC X(20) VALUE "Insufficient Funds".
             10 TEST-AMOUNT  PIC 9(6)V99 VALUE 2000.00.
             10 EXP-RESULT   PIC 9(6)V99 VALUE 1000.00.
          05 FILLER.
             10 TEST-NAME    PIC X(20) VALUE "Zero Debit".
             10 TEST-AMOUNT  PIC 9(6)V99 VALUE 0.00.
             10 EXP-RESULT   PIC 9(6)V99 VALUE 1000.00.

      *> Test Assertions
       01 ASSERT-EQUAL       PIC X(20) VALUE "ASSERT-EQUAL-FAILED".
       01 ASSERT-MSG         PIC X(30) VALUE "Insufficient funds for this debit.".

       PROCEDURE DIVISION.
       MAIN-LOGIC.
      *> Test Setup
           CALL 'DataProgram' USING 'WRITE', TEST-INIT-BALANCE

      *> Test Case TC-3.1: Valid Debit Amount
           MOVE TEST-AMOUNT(1) TO AMOUNT
           CALL 'Operations' USING 'DEBIT'
           IF FINAL-BALANCE NOT = EXP-RESULT(1)
               DISPLAY ASSERT-EQUAL " " TEST-NAME(1)
               DISPLAY "Expected: " EXP-RESULT(1)
               DISPLAY "Actual: " FINAL-BALANCE
               ADD 1 TO FAIL-COUNT
           ELSE
               ADD 1 TO PASS-COUNT
           END-IF

      *> Reset for next test
           CALL 'DataProgram' USING 'WRITE', TEST-INIT-BALANCE

      *> Test Case TC-3.2: Insufficient Funds
           MOVE TEST-AMOUNT(2) TO AMOUNT
           CALL 'Operations' USING 'DEBIT'
           IF FINAL-BALANCE NOT = EXP-RESULT(2)
               DISPLAY ASSERT-EQUAL " " TEST-NAME(2)
               DISPLAY "Expected: " EXP-RESULT(2)
               DISPLAY "Actual: " FINAL-BALANCE
               ADD 1 TO FAIL-COUNT
           ELSE
               ADD 1 TO PASS-COUNT
           END-IF

      *> Reset for next test
           CALL 'DataProgram' USING 'WRITE', TEST-INIT-BALANCE

      *> Test Case TC-3.3: Zero Debit Amount
           MOVE TEST-AMOUNT(3) TO AMOUNT
           CALL 'Operations' USING 'DEBIT'
           IF FINAL-BALANCE NOT = EXP-RESULT(3)
               DISPLAY ASSERT-EQUAL " " TEST-NAME(3)
               DISPLAY "Expected: " EXP-RESULT(3)
               DISPLAY "Actual: " FINAL-BALANCE
               ADD 1 TO FAIL-COUNT
           ELSE
               ADD 1 TO PASS-COUNT
           END-IF

      *> Test Summary
           DISPLAY "Debit Tests Complete"
           DISPLAY "Passed: " PASS-COUNT " of " TOTAL-COUNT
           DISPLAY "Failed: " FAIL-COUNT " of " TOTAL-COUNT

           GOBACK.
