
      *> Standard Test Assertions Copybook
      *> Version: 1.0
      *> Provides common assertions for COBOL unit tests

       01 TEST-ASSERTIONS.
          05 ASSERT-EQUAL        PIC X(20) VALUE "ASSERT-EQUAL-FAILED".
          05 ASSERT-NOT-EQUAL    PIC X(20) VALUE "ASSERT-NOT-EQUAL-FAILED".
          05 ASSERT-TRUE         PIC X(20) VALUE "ASSERT-TRUE-FAILED".
          05 ASSERT-FALSE        PIC X(20) VALUE "ASSERT-FALSE-FAILED".
          05 ASSERT-NULL         PIC X(20) VALUE "ASSERT-NULL-FAILED".
          05 ASSERT-NOT-NULL     PIC X(20) VALUE "ASSERT-NOT-NULL-FAILED".

       01 TEST-RESULTS.
          05 TEST-COUNT         PIC 9(4) VALUE 0.
          05 PASS-COUNT         PIC 9(4) VALUE 0.
          05 FAIL-COUNT         PIC 9(4) VALUE 0.
          05 TEST-NAME          PIC X(30).

      *> Assertion Macros
       PROCEDURE DIVISION.
      *> ASSERT-EQUAL-VALUE
       ASSERT-EQUAL-VALUE USING EXPECTED, ACTUAL, MSG.
           ADD 1 TO TEST-COUNT
           IF EXPECTED NOT = ACTUAL
               DISPLAY ASSERT-EQUAL " - " MSG
               DISPLAY "Expected: " EXPECTED
               DISPLAY "Actual: " ACTUAL
               ADD 1 TO FAIL-COUNT
           ELSE
               ADD 1 TO PASS-COUNT
           END-IF.

      *> ASSERT-TRUE
       ASSERT-TRUE USING CONDITION, MSG.
           ADD 1 TO TEST-COUNT
           IF NOT CONDITION
               DISPLAY ASSERT-TRUE " - " MSG
               ADD 1 TO FAIL-COUNT
           ELSE
               ADD 1 TO PASS-COUNT
           END-IF.
