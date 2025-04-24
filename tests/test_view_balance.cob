
      * Test program for viewing account balance
       IDENTIFICATION DIVISION.
       PROGRAM-ID. TestViewBalance.

       DATA DIVISION.
       WORKING-STORAGE SECTION.
       COPY balancews.
       01 EXPECTED-BALANCE PIC 9(6)V99 VALUE 1000.00.

       LINKAGE SECTION.
       COPY balancels.

       PROCEDURE DIVISION.
       DISPLAY "TEST TC-1.1: View Current Balance".
      * Initialize balance
       MOVE 'WRITE' TO WS-OPERATION.
       MOVE 1000.00 TO WS-VALUE.
       CALL 'DataProgram' USING WS-BALANCE-REC.
      * View balance
       MOVE 'TOTAL ' TO WS-OPERATION.
       CALL 'Operations' USING WS-BALANCE-REC.
       DISPLAY "Expected balance: 001000.00".
       DISPLAY "Test completed".
       GOBACK.
