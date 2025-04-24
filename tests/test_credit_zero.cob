
      * Test program for zero credit amount
       IDENTIFICATION DIVISION.
       PROGRAM-ID. TestCreditZero.

       DATA DIVISION.
       WORKING-STORAGE SECTION.
       COPY balancews.

       LINKAGE SECTION.
       COPY balancels.

       PROCEDURE DIVISION.
       DISPLAY "TEST TC-2.2: Credit Account with Zero Amount".
      * Initialize balance
       MOVE 'WRITE' TO WS-OPERATION.
       MOVE 1000.00 TO WS-VALUE.
       CALL 'DataProgram' USING WS-BALANCE-REC.
      * Run test with zero amount
       MOVE 'CREDIT' TO WS-OPERATION.
       MOVE 0 TO WS-AMOUNT.
       MOVE 'Y' TO WS-TEST-FLAG.
       CALL 'Operations' USING WS-BALANCE-REC.
      * Verify balance remains unchanged
       MOVE 'READ' TO WS-OPERATION.
       CALL 'DataProgram' USING WS-BALANCE-REC.
       IF WS-VALUE = 1000.00
           DISPLAY "SUCCESS: Balance remains " WS-VALUE
       ELSE
           DISPLAY "FAILURE: Expected 001000.00 but got " WS-VALUE
       END-IF.
       DISPLAY "Test completed".
       GOBACK.
