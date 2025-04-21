
       IDENTIFICATION DIVISION.
       PROGRAM-ID. CreditTests.

       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01 INITIAL-BALANCE    PIC 9(6)V99 VALUE 1000.00.
       01 TEST-AMOUNT        PIC 9(6)V99 VALUE 100.00.
       01 TEST-RESULT        PIC X(4) VALUE 'FAIL'.
       01 OPERATION-TYPE     PIC X(6) VALUE 'CREDIT'.

       PROCEDURE DIVISION.
       MAIN-LOGIC.
           DISPLAY "Running Credit Tests..."

           *> Test TC-2.1: Valid credit amount
           CALL 'Operations' USING OPERATION-TYPE
           MOVE 100.00 TO TEST-AMOUNT
           IF FINAL-BALANCE = INITIAL-BALANCE + TEST-AMOUNT
               MOVE 'PASS' TO TEST-RESULT
           END-IF
           DISPLAY "TC-2.1 (Valid Credit): " TEST-RESULT

           *> Test TC-2.2: Zero credit amount
           MOVE 'FAIL' TO TEST-RESULT
           CALL 'Operations' USING OPERATION-TYPE
           MOVE 0.00 TO TEST-AMOUNT
           IF FINAL-BALANCE = INITIAL-BALANCE
               MOVE 'PASS' TO TEST-RESULT
           END-IF
           DISPLAY "TC-2.2 (Zero Credit): " TEST-RESULT

           GOBACK.
