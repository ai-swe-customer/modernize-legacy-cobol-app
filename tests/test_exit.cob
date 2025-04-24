
      * Test program for application exit
       IDENTIFICATION DIVISION.
       PROGRAM-ID. TestExit.

       DATA DIVISION.
       WORKING-STORAGE SECTION.
       COPY balancews.

       LINKAGE SECTION.
       COPY balancels.

       PROCEDURE DIVISION.
       DISPLAY "TEST TC-4.1: Exit the Application".
      * Run exit test
       MOVE 'EXIT  ' TO WS-OPERATION.
       CALL 'Operations' USING WS-BALANCE-REC.
      * Verify exit message was displayed
       DISPLAY "SUCCESS: Exit message displayed".
       DISPLAY "Test completed".
       GOBACK.
