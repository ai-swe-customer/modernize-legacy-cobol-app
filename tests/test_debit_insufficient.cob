
       IDENTIFICATION DIVISION.
       PROGRAM-ID. TestDebitInsufficient.

       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01 OPERATION         PIC X(6) VALUE 'DEBIT '.
       01 AMOUNT            PIC 9(6)V99 VALUE 2000.00.
       01 INITIAL-BALANCE   PIC 9(6)V99 VALUE 1000.00.
       01 EXPECTED-BALANCE  PIC 9(6)V99 VALUE 1000.00.
       01 ACTUAL-BALANCE    PIC 9(6)V99.
       01 INSUFFICIENT-MSG  PIC X(30) VALUE "Insufficient funds for this debit".

       PROCEDURE DIVISION.
           CALL 'data' USING 'WRITE', INITIAL-BALANCE
           CALL 'Operations' USING OPERATION
           *> Simulate user input
           CALL 'data' USING 'READ', ACTUAL-BALANCE
           *> Check balance remains unchanged
           IF ACTUAL-BALANCE = EXPECTED-BALANCE
               DISPLAY "TEST PASSED: Debit Insufficient Funds"
               MOVE 0 TO RETURN-CODE
           ELSE
               DISPLAY "TEST FAILED: Debit Insufficient Funds"
               DISPLAY "Expected balance: " EXPECTED-BALANCE
               DISPLAY "Actual balance: " ACTUAL-BALANCE
               MOVE 1 TO RETURN-CODE
           END-IF
           STOP RUN.
