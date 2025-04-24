
      * Test program for crediting account
       IDENTIFICATION DIVISION.
       PROGRAM-ID. TestCreditValid.

       DATA DIVISION.
       WORKING-STORAGE SECTION.
       COPY balancews.
       01 EXPECTED-BALANCE PIC 9(6)V99 VALUE 1100.00.

       LINKAGE SECTION.
       COPY balancels.

       PROCEDURE DIVISION.
       DISPLAY "TEST TC-2.1: Credit Account with Valid Amount".
      * Initialize balance
       MOVE 'WRITE' TO WS-OPERATION.
       MOVE 1000.00 TO WS-VALUE.
       CALL 'DataProgram' USING WS-BALANCE-REC.
      * Run test with test amount
       MOVE 'CREDIT' TO WS-OPERATION.
       MOVE 100.00 TO WS-AMOUNT.
       MOVE 'Y' TO WS-TEST-FLAG.
       CALL 'Operations' USING WS-BALANCE-REC.
      * Verify results
       MOVE 'READ' TO WS-OPERATION.
       CALL 'DataProgram' USING WS-BALANCE-REC.
       IF WS-VALUE = 1100.00
           DISPLAY "SUCCESS: Balance updated to " WS-VALUE
       ELSE
           DISPLAY "FAILURE: Expected 001100.00 but got " WS-VALUE
       END-IF.
       DISPLAY "Test completed".
       GOBACK.
