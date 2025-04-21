
       IDENTIFICATION DIVISION.
       PROGRAM-ID. TestCredit.

       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01 INITIAL-BALANCE   PIC 9(6)V99 VALUE 1000.00.
       01 TEST-AMOUNT       PIC 9(6)V99 VALUE 500.00.
       01 EXPECTED-BALANCE  PIC 9(6)V99.
       01 MOCK-BALANCE      PIC 9(6)V99.
       01 OPERATION-TYPE    PIC X(6) VALUE "CREDIT".
       01 TEST-RESULT       PIC X(20) VALUE SPACES.

       PROCEDURE DIVISION.
       MAIN.
           DISPLAY "TESTING CREDIT OPERATION".
           
           *> Test case 1: Valid credit amount
           MOVE 500.00 TO TEST-AMOUNT
           PERFORM TEST-CREDIT
           
           *> Test case 2: Zero amount
           MOVE 0.00 TO TEST-AMOUNT
           PERFORM TEST-CREDIT
           
           DISPLAY "CREDIT TESTS COMPLETE".
           STOP RUN.

       TEST-CREDIT.
           *> Setup expected result
           COMPUTE EXPECTED-BALANCE = INITIAL-BALANCE + TEST-AMOUNT
           
           *> Reset mock balance
           MOVE INITIAL-BALANCE TO MOCK-BALANCE
           CALL "DataProgram" USING "WRITE", MOCK-BALANCE
           
           *> Execute operation
           CALL "Operations" USING OPERATION-TYPE
           
           *> Verify final balance
           CALL "DataProgram" USING "READ", MOCK-BALANCE
           
           *> Verify results
           IF MOCK-BALANCE = EXPECTED-BALANCE
               MOVE "TEST PASSED: CREDIT" TO TEST-RESULT
           ELSE
               MOVE "TEST FAILED: CREDIT" TO TEST-RESULT
               DISPLAY "Amount: " TEST-AMOUNT
               DISPLAY "Expected: " EXPECTED-BALANCE
               DISPLAY "Actual:   " MOCK-BALANCE
           END-IF.
           DISPLAY TEST-RESULT.
       END PROGRAM TestCredit.
