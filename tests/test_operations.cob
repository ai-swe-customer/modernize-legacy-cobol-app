
       IDENTIFICATION DIVISION.
       PROGRAM-ID. TestOperations.

       ENVIRONMENT DIVISION.
       CONFIGURATION SECTION.
       REPOSITORY.
           FUNCTION ALL INTRINSIC
           COPY "CobolUnit".

       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01 TEST-SUITE        PIC X(30) VALUE 'Operations Tests'.
       01 TEST-CASE         PIC X(30).
       01 EXPECTED-BALANCE  PIC 9(6)V99.
       01 ACTUAL-BALANCE    PIC 9(6)V99.
       01 TEST-AMOUNT       PIC 9(6)V99.

       PROCEDURE DIVISION.
       MAIN SECTION.
           PERFORM INITIALIZE-TEST
           PERFORM RUN-TESTS
           GOBACK.

       INITIALIZE-TEST SECTION.
           MOVE 1000.00 TO EXPECTED-BALANCE
           CALL "DataProgram" USING "WRITE", EXPECTED-BALANCE.

       RUN-TESTS SECTION.
           CALL "CobolUnit.Run" USING TEST-SUITE.

           *> Test Case TC-1.1: View Current Balance
           MOVE 'TC-1.1: View Balance' TO TEST-CASE
           CALL "CobolUnit.StartTest" USING TEST-CASE
           CALL "Operations" USING "TOTAL"
           CALL "DataProgram" USING "READ", ACTUAL-BALANCE
           CALL "CobolUnit.AssertEquals" USING 
               "Balance should match", EXPECTED-BALANCE, ACTUAL-BALANCE
           CALL "CobolUnit.EndTest"

           *> Test Cases TC-2.1/2.2: Credit Account
           MOVE 'TC-2.1: Credit Valid' TO TEST-CASE
           CALL "CobolUnit.StartTest" USING TEST-CASE
           MOVE 200.00 TO TEST-AMOUNT
           COMPUTE EXPECTED-BALANCE = EXPECTED-BALANCE + TEST-AMOUNT
           CALL "Operations" USING "CREDIT"
           *> Simulate user input
           MOVE TEST-AMOUNT TO AMOUNT
           CALL "DataProgram" USING "READ", ACTUAL-BALANCE
           CALL "CobolUnit.AssertEquals" USING 
               "Balance after credit", EXPECTED-BALANCE, ACTUAL-BALANCE
           CALL "CobolUnit.EndTest"

           MOVE 'TC-2.2: Credit Zero' TO TEST-CASE
           CALL "CobolUnit.StartTest" USING TEST-CASE
           MOVE 0.00 TO TEST-AMOUNT
           COMPUTE EXPECTED-BALANCE = EXPECTED-BALANCE + TEST-AMOUNT
           CALL "Operations" USING "CREDIT"
           *> Simulate user input
           MOVE TEST-AMOUNT TO AMOUNT
           CALL "DataProgram" USING "READ", ACTUAL-BALANCE
           CALL "CobolUnit.AssertEquals" USING 
               "Balance after zero credit", EXPECTED-BALANCE, ACTUAL-BALANCE
           CALL "CobolUnit.EndTest"

           *> Test Cases TC-3.1-3.3: Debit Account
           MOVE 'TC-3.1: Debit Valid' TO TEST-CASE
           CALL "CobolUnit.StartTest" USING TEST-CASE
           MOVE 50.00 TO TEST-AMOUNT
           COMPUTE EXPECTED-BALANCE = EXPECTED-BALANCE - TEST-AMOUNT
           CALL "Operations" USING "DEBIT"
           *> Simulate user input
           MOVE TEST-AMOUNT TO AMOUNT
           CALL "DataProgram" USING "READ", ACTUAL-BALANCE
           CALL "CobolUnit.AssertEquals" USING 
               "Balance after debit", EXPECTED-BALANCE, ACTUAL-BALANCE
           CALL "CobolUnit.EndTest"

           MOVE 'TC-3.2: Debit Over' TO TEST-CASE
           CALL "CobolUnit.StartTest" USING TEST-CASE
           MOVE 2000.00 TO TEST-AMOUNT
           *> Store original balance
           MOVE EXPECTED-BALANCE TO ACTUAL-BALANCE
           CALL "Operations" USING "DEBIT"
           *> Simulate user input
           MOVE TEST-AMOUNT TO AMOUNT
           CALL "DataProgram" USING "READ", ACTUAL-BALANCE
           CALL "CobolUnit.AssertEquals" USING 
               "Balance should not change", EXPECTED-BALANCE, ACTUAL-BALANCE
           CALL "CobolUnit.EndTest"

           MOVE 'TC-3.3: Debit Zero' TO TEST-CASE
           CALL "CobolUnit.StartTest" USING TEST-CASE
           MOVE 0.00 TO TEST-AMOUNT
           COMPUTE EXPECTED-BALANCE = EXPECTED-BALANCE - TEST-AMOUNT
           CALL "Operations" USING "DEBIT"
           *> Simulate user input
           MOVE TEST-AMOUNT TO AMOUNT
           CALL "DataProgram" USING "READ", ACTUAL-BALANCE
           CALL "CobolUnit.AssertEquals" USING 
               "Balance after zero debit", EXPECTED-BALANCE, ACTUAL-BALANCE
           CALL "CobolUnit.EndTest"

           *> Test Case TC-4.1: Exit Application
           MOVE 'TC-4.1: Exit App' TO TEST-CASE
           CALL "CobolUnit.StartTest" USING TEST-CASE
           *> Exit test is handled by framework
           CALL "CobolUnit.EndTest"

           CALL "CobolUnit.EndSuite".
