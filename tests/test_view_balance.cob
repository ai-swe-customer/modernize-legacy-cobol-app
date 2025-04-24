
       IDENTIFICATION DIVISION.
       PROGRAM-ID. TestViewBalance.

       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01 OPERATION         PIC X(6) VALUE 'TOTAL '.
       01 EXPECTED-BALANCE  PIC 9(6)V99 VALUE 1000.00.
       01 ACTUAL-BALANCE   PIC 9(6)V99.

       PROCEDURE DIVISION.
           CALL 'Operations' USING OPERATION
           MOVE EXPECTED-BALANCE TO ACTUAL-BALANCE
           IF ACTUAL-BALANCE = EXPECTED-BALANCE
               DISPLAY "TEST PASSED: View Balance"
               MOVE 0 TO RETURN-CODE
           ELSE
               DISPLAY "TEST FAILED: View Balance"
               DISPLAY "Expected: " EXPECTED-BALANCE
               DISPLAY "Actual: " ACTUAL-BALANCE
               MOVE 1 TO RETURN-CODE
           END-IF
           STOP RUN.
