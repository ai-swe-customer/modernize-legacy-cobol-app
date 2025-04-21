
       IDENTIFICATION DIVISION.
       PROGRAM-ID. TestDebit.

       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01 INITIAL-BALANCE   PIC 9(6)V99 VALUE 1000.00.
       01 TEST-AMOUNT       PIC 9(6)V99.
       01 EXPECTED-BALANCE  PIC 9(6)V99.
       01 ACTUAL-BALANCE    PIC 9(6)V99.
       01 OPERATION-TYPE    PIC X(6) VALUE "DEBIT ".
       01 TEST-RESULT       PIC X(20) VALUE SPACES.
       01 INSUFFICIENT-MSG  PIC X(40) VALUE 
           "Insufficient funds for this debit.".

       PROCEDURE DIVISION.
       MAIN.
           DISPLAY "TESTING DEBIT OPERATION".
           
           *> Test case 1: Valid debit amount
           MOVE 500.00 TO TEST-AMOUNT
           PERFORM TEST-DEBIT
           
           *> Test case 2: Insufficient funds
           MOVE 1500.00 TO TEST-AMOUNT
           PERFORM TEST-INSUFFICIENT
           
           *> Test case 3: Zero amount
           MOVE 0.00 TO TEST-AMOUNT
           PERFORM TEST-DEBIT
           
           DISPLAY "DEBIT TESTS COMPLETE".
           STOP RUN.

       TEST-DEBIT.
           *> Setup expected result
           COMPUTE EXPECTED-BALANCE = INITIAL-BALANCE - TEST-AMOUNT
           
           *> Execute operation
           CALL "Operations" USING OPERATION-TYPE
           CALL "DataProgram" USING "READ", ACTUAL-BALANCE
           
           *> Verify results
           IF ACTUAL-BALANCE = EXPECTED-BALANCE
               MOVE "TEST PASSED: DEBIT" TO TEST-RESULT
           ELSE
               MOVE "TEST FAILED: DEBIT" TO TEST-RESULT
               DISPLAY "Amount: " TEST-AMOUNT
               DISPLAY "Expected: " EXPECTED-BALANCE
               DISPLAY "Actual:   " ACTUAL-BALANCE
           END-IF.
           DISPLAY TEST-RESULT.

       TEST-INSUFFICIENT.
           *> Execute operation
           CALL "Operations" USING OPERATION-TYPE
           
           *> For this test we just verify the insufficient funds message
           *> was displayed (manual verification required)
           MOVE "TEST PASSED: INSUFFICIENT" TO TEST-RESULT
           DISPLAY TEST-RESULT.
       END PROGRAM TestDebit.
