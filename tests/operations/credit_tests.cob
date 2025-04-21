
       IDENTIFICATION DIVISION.
       PROGRAM-ID. CreditTests.
      *> Test cases for account crediting (TC-2.1, TC-2.2)
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
          05 TOTAL-COUNT     PIC 9(2) VALUE 2.

      *> Test Cases
       01 TEST-CASES.
          05 FILLER.
             10 TEST-NAME    PIC X(20) VALUE "Valid Credit".
             10 TEST-AMOUNT  PIC 9(6)V99 VALUE 100.00.
             10 EXP-RESULT   PIC 9(6)V99 VALUE 1100.00.
          05 FILLER.
             10 TEST-NAME    PIC X(20) VALUE "Zero Credit".
             10 TEST-AMOUNT  PIC 9(6)V99 VALUE 0.00.
             10 EXP-RESULT   PIC 9(6)V99 VALUE 1000.00.

      *> Test Assertions
       01 ASSERT-EQUAL       PIC X(20) VALUE "ASSERT-EQUAL-FAILED".

       PROCEDURE DIVISION.
       MAIN-LOGIC.
      *> Test Setup
           CALL 'DataProgram' USING 'WRITE', TEST-INIT-BALANCE

      *> Test Case TC-2.1: Valid Credit Amount
           MOVE TEST-AMOUNT(1) TO AMOUNT
           CALL 'Operations' USING 'CREDIT'
           IF FINAL-BALANCE NOT = EXP-RESULT(1)
               DISPLAY ASSERT-EQUAL " " TEST-NAME(1)
                        " Expected: " EXP-RESULT(1)
                        " Actual: " FINAL-BALANCE
               ADD 1 TO FAIL-COUNT
           ELSE
               ADD 1 TO PASS-COUNT
           END-IF

      *> Reset for next test
           CALL 'DataProgram' USING 'WRITE', TEST-INIT-BALANCE

      *> Test Case TC-2.2: Zero Credit Amount
           MOVE TEST-AMOUNT(2) TO AMOUNT
           CALL 'Operations' USING 'CREDIT'
           IF FINAL-BALANCE NOT = EXP-RESULT(2)
               DISPLAY ASSERT-EQUAL " " TEST-NAME(2)
                        " Expected: " EXP-RESULT(2)
                        " Actual: " FINAL-BALANCE
               ADD 1 TO FAIL-COUNT
           ELSE

           GOBACK.
