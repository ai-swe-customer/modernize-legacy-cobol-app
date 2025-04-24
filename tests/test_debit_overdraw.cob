
      * Test program for overdraw protection
       IDENTIFICATION DIVISION.
       PROGRAM-ID. TestDebitOverdraw.

       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01 TEST-PARAMS.
           05 TEST-OPERATION PIC X(6) VALUE 'DEBIT '.
           05 TEST-AMOUNT PIC 9(6)V99 VALUE 2000.00.
           05 TEST-FLAG PIC X VALUE 'Y'.
       01 EXPECTED-BALANCE PIC 9(6)V99 VALUE 1000.00.
       01 INITIAL-BALANCE PIC 9(6)V99 VALUE 1000.00.
       01 OPERATION PIC X(6).
       01 BALANCE PIC 9(6)V99.
       01 INSUFFICIENT-FUNDS PIC X(25) VALUE 
           "Insufficient funds for this debit".

       PROCEDURE DIVISION.
       DISPLAY "TEST TC-3.2: Debit Account with Amount > Balance".
      * Set initial balance
       MOVE 'WRITE' TO OPERATION.
       MOVE INITIAL-BALANCE TO BALANCE.
       CALL 'DataProgram' USING OPERATION BALANCE.
      * Run test with test amount
       CALL 'Operations' USING TEST-PARAMS.
      * Verify results
       MOVE 'READ' TO OPERATION.
       CALL 'DataProgram' USING OPERATION BALANCE.
       IF BALANCE = EXPECTED-BALANCE
           DISPLAY "SUCCESS: Balance remains " BALANCE
       ELSE
           DISPLAY "FAILURE: Expected " EXPECTED-BALANCE 
                   " but got " BALANCE
       END-IF.
       DISPLAY "Test completed".
       GOBACK.
