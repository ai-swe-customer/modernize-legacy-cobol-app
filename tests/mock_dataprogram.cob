
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
