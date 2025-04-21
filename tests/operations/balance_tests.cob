
       IDENTIFICATION DIVISION.
       PROGRAM-ID. BalanceTests.
      *> Test cases for balance viewing functionality (TC-1.1)
      *> Version: 1.2
      *> Uses standard test assertions

       DATA DIVISION.
       COPY "../test_assertions.cpy".
       COPY "operations.cpy".

       WORKING-STORAGE SECTION.
      *> Test Configuration
       01 TEST-INIT-BALANCE  PIC 9(6)V99 VALUE 1500.00.
       01 TEST-ERROR         PIC X(80) VALUE SPACES.

       PROCEDURE DIVISION.
       MAIN-LOGIC.
      *> Test Setup
           CALL 'DataProgram' USING 'WRITE', TEST-INIT-BALANCE
           IF RETURN-CODE NOT = 0
               DISPLAY "SETUP FAILED: Unable to initialize test data"
               STOP RUN RETURNING 1
           END-IF

      *> Test Case TC-1.1: View Current Balance
           MOVE "TC-1.1: View Balance" TO TEST-NAME
           CALL 'Operations' USING 'TOTAL'
           IF RETURN-CODE NOT = 0
               DISPLAY "TEST FAILED: Operations call failed"
               ADD 1 TO FAIL-COUNT
           ELSE
               CALL "ASSERT-EQUAL-VALUE" USING TEST-INIT-BALANCE, FINAL-BALANCE, "Balance should match"
           END-IF

      *> Test Summary
           DISPLAY "Balance Tests Complete: " PASS-COUNT " passed, " FAIL-COUNT " failed of " TEST-COUNT " tests"

           GOBACK.
