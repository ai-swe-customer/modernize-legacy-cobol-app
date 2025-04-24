       IDENTIFICATION DIVISION.
       PROGRAM-ID. Operations.

       DATA DIVISION.
       WORKING-STORAGE SECTION.
       COPY balancews.
       01 OPERATION-TYPE     PIC X(6).
       01 AMOUNT             PIC 9(6)V99.
       01 TEST-MODE          PIC X VALUE 'N'.
           88 IS-TEST VALUE 'Y'.

       LINKAGE SECTION.
       COPY balancels.

       PROCEDURE DIVISION USING LS-BALANCE-REC.
           MOVE LS-OPERATION TO OPERATION-TYPE
           IF LS-TEST-FLAG = 'Y'
               SET IS-TEST TO TRUE
               MOVE LS-AMOUNT TO AMOUNT
           END-IF

           IF OPERATION-TYPE = 'TOTAL '
               MOVE LS-BALANCE-REC TO WS-BALANCE-REC
               CALL 'DataProgram' USING WS-BALANCE-REC
               MOVE WS-BALANCE-REC TO LS-BALANCE-REC
               DISPLAY "Current balance: " LS-VALUE

           ELSE IF OPERATION-TYPE = 'CREDIT'
               IF NOT IS-TEST
                   DISPLAY "Enter credit amount: "
                   ACCEPT AMOUNT
               END-IF
               IF AMOUNT = 0
                   DISPLAY "Error: Cannot credit zero amount"
               ELSE
                   MOVE 'READ' TO WS-OPERATION
                   CALL 'DataProgram' USING WS-BALANCE-REC
                   ADD AMOUNT TO WS-VALUE
                   MOVE 'WRITE' TO WS-OPERATION
                   CALL 'DataProgram' USING WS-BALANCE-REC
                   MOVE WS-VALUE TO LS-VALUE
                   DISPLAY "Amount credited. New balance: " LS-VALUE
               END-IF

           ELSE IF OPERATION-TYPE = 'EXIT  '
               DISPLAY "Application terminated"
               STOP RUN

           ELSE IF OPERATION-TYPE = 'DEBIT '
               IF NOT IS-TEST
                   DISPLAY "Enter debit amount: "
                   ACCEPT AMOUNT
               END-IF
               IF AMOUNT = 0
                   DISPLAY "Error: Cannot debit zero amount"
               ELSE
                   MOVE 'READ' TO WS-OPERATION
                   CALL 'DataProgram' USING WS-BALANCE-REC
                   IF WS-VALUE >= AMOUNT
                       SUBTRACT AMOUNT FROM WS-VALUE
                       MOVE 'WRITE' TO WS-OPERATION
                       CALL 'DataProgram' USING WS-BALANCE-REC
                       MOVE WS-VALUE TO LS-VALUE
                       DISPLAY "Amount debited. New balance: " LS-VALUE
                   ELSE
                       DISPLAY "Insufficient funds for this debit."
                   END-IF
               END-IF
           END-IF
           GOBACK.
