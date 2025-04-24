
       IDENTIFICATION DIVISION.
       PROGRAM-ID. TestCreditValid.

       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01 OPERATION         PIC X(6) VALUE 'CREDIT'.
       01 AMOUNT            PIC 9(6)V99 VALUE 100.00.
       01 INITIAL-BALANCE   PIC 9(6)V99 VALUE 1000.00.
       01 EXPECTED-BALANCE  PIC 9(6)V99 VALUE 1100.00.
       01 ACTUAL-BALANCE    PIC 9(6)V99.

       PROCEDURE DIVISION.
           CALL 'data' USING 'WRITE', INITIAL-BALANCE
           CALL 'Operations' USING OPERATION
           *> Simulate user input
           CALL 'data' USING 'READ', ACTUAL-BALANCE
           IF ACTUAL-BALANCE = EXPECTED-BALANCE
               DISPLAY "TEST PASSED: Credit Valid Amount"
               MOVE 0 TO RETURN-CODE
           ELSE
               DISPLAY "TEST FAILED: Credit Valid Amount"
               DISPLAY "Expected: " EXPECTED-BALANCE
               DISPLAY "Actual: " ACTUAL-BALANCE
               MOVE 1 TO RETURN-CODE
           END-IF
           STOP RUN.
