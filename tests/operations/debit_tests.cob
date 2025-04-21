
       IDENTIFICATION DIVISION.
       PROGRAM-ID. DebitTests.

       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01 INITIAL-BALANCE    PIC 9(6)V99 VALUE 1000.00.
       01 TEST-AMOUNT        PIC 9(6)V99.
       01 TEST-RESULT        PIC X(4) VALUE 'FAIL'.
       01 OPERATION-TYPE    PIC X(6) VALUE 'DEBIT '.
       01 INSUFFICIENT-MSG  PIC X(30) VALUE SPACES.

       PROCEDURE DIVISION.
       MAIN-LOGIC.
           DISPLAY "Running Debit Tests..."

           *> Test TC-3.1: Valid debit amount
           MOVE 50.00 TO TEST-AMOUNT
           CALL 'Operations' USING OPERATION-TYPE
           IF FINAL-BALANCE = INITIAL-BALANCE - TEST-AMOUNT
               MOVE 'PASS' TO TEST-RESULT
           END-IF
           DISPLAY "TC-3.1 (Valid Debit): " TEST-RESULT

           *> Test TC-3.2: Insufficient funds
           MOVE 'FAIL' TO TEST-RESULT
           MOVE 2000.00 TO TEST-AMOUNT
           CALL 'Operations' USING OPERATION-TYPE
           IF FINAL-BALANCE = INITIAL-BALANCE AND
              INSUFFICIENT-MSG = "Insufficient funds for this debit."
               MOVE 'PASS' TO TEST-RESULT
           END-IF
           DISPLAY "TC-3.2 (Insufficient Funds): " TEST-RESULT

           *> Test TC-3.3: Zero debit amount
           MOVE 'FAIL' TO TEST-RESULT
           MOVE 0.00 TO TEST-AMOUNT
           CALL 'Operations' USING OPERATION-TYPE
           IF FINAL-BALANCE = INITIAL-BALANCE
               MOVE 'PASS' TO TEST-RESULT
           END-IF
           DISPLAY "TC-3.3 (Zero Debit): " TEST-RESULT

           GOBACK.
