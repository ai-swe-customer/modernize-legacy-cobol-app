
       IDENTIFICATION DIVISION.
       PROGRAM-ID. TestTotal.

       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01 OPERATION-TYPE    PIC X(6) VALUE "TOTAL ".
       01 EXPECTED-BALANCE  PIC 9(6)V99 VALUE 1000.00.
       01 ACTUAL-BALANCE    PIC 9(6)V99.
       01 TEST-RESULT       PIC X(20) VALUE SPACES.

       PROCEDURE DIVISION.
       MAIN.
           DISPLAY "TESTING TOTAL OPERATION".
           
           *> Execute operation
           CALL "Operations" USING OPERATION-TYPE
           
           *> Verify balance
           CALL "DataProgram" USING "READ", ACTUAL-BALANCE
           
           *> Check results
           IF ACTUAL-BALANCE = EXPECTED-BALANCE
               MOVE "TEST PASSED: TOTAL" TO TEST-RESULT
           ELSE
               MOVE "TEST FAILED: TOTAL" TO TEST-RESULT
               DISPLAY "Expected: " EXPECTED-BALANCE
               DISPLAY "Actual:   " ACTUAL-BALANCE
           END-IF.
           DISPLAY TEST-RESULT.
           STOP RUN.

       *> Mock DataProgram implementation
       IDENTIFICATION DIVISION.
       PROGRAM-ID. DataProgram.

       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01 MOCK-BALANCE      PIC 9(6)V99 VALUE 1000.00.

       LINKAGE SECTION.
       01 OPERATION         PIC X(4).
       01 BALANCE           PIC 9(6)V99.

       PROCEDURE DIVISION USING OPERATION, BALANCE.
           EVALUATE OPERATION
               WHEN "READ"
                   MOVE MOCK-BALANCE TO BALANCE
               WHEN "WRITE"
                   MOVE BALANCE TO MOCK-BALANCE
           END-EVALUATE.
           GOBACK.
       END PROGRAM DataProgram.

       END PROGRAM TestTotal.
