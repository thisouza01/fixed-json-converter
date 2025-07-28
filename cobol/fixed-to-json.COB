      ******************************************************************
      * Author: Thiago Souza
      * Date: 28/07/2025
      * Purpose: Converter arquivo Fixo para JSON
      * Tectonics: cobc
      ******************************************************************
       IDENTIFICATION DIVISION.
       PROGRAM-ID. FIXED-FORMAT-TO-JSON.
       ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
           SELECT ARQIN ASSIGN TO "C:\json-to-fixed-format\usuarios.txt"
               ORGANIZATION IS LINE SEQUENTIAL
               ACCESS MODE IS SEQUENTIAL
               FILE STATUS IS WK-FS-ARQIN.

           SELECT ARQOUT ASSIGN TO "C:\json-to-fixed-format\users.json"
               ORGANIZATION IS LINE SEQUENTIAL
               ACCESS MODE IS SEQUENTIAL
               FILE STATUS IS WK-FS-ARQOUT.

           DATA DIVISION.
           FILE SECTION.
           FD  ARQIN.
           01  REG-IN.
               03  FD-NAME         PIC X(15).
               03  FD-EMAIL        PIC X(30).
               03  FD-BALANCE      PIC 9(05)V99.

           FD  ARQOUT.
           01  REG-OUT             PIC X(500).

           WORKING-STORAGE SECTION.
           77  WK-FS-ARQIN             PIC 99      VALUE ZEROS.
           77  WK-FS-ARQOUT            PIC 99      VALUE ZEROS.
           77  WK-FIRST-RECORD         PIC X       VALUE 'Y'.

           77  WS-BALANCE-NUM          PIC 9(04)V99.
           77  WS-BALANCE-FORMATTED    PIC Z(4)9.99.

           PROCEDURE DIVISION.
       0000-MAIN.
           PERFORM 000-OPEN-DATA
           PERFORM 100-PROCESS-DATA
           PERFORM 900-CLOSE-DATA
           STOP RUN.

       000-OPEN-DATA.
           OPEN INPUT ARQIN
           OPEN OUTPUT ARQOUT
           MOVE '{"Usuarios": [' TO REG-OUT
           WRITE REG-OUT.

       100-PROCESS-DATA.
           PERFORM UNTIL WK-FS-ARQIN = 10
               READ ARQIN
                   AT END
                       MOVE 10 TO WK-FS-ARQIN
                       PERFORM 300-CLOSE-JSON
                    NOT AT END
                       PERFORM 200-CONVERT-TO-JSON
               END-READ
           END-PERFORM.

       200-CONVERT-TO-JSON.
           PERFORM 400-CONVERT-BALANCE.

           IF WK-FIRST-RECORD = 'N'
               MOVE ',' TO REG-OUT
               WRITE REG-OUT
           ELSE
               MOVE 'N' TO WK-FIRST-RECORD
           END-IF.

           STRING
                '{'
                '"Nome": "'      DELIMITED BY SIZE
                FUNCTION TRIM(FD-NAME)  DELIMITED BY SPACE
                '", '           DELIMITED BY SIZE
                '"Email": "'    DELIMITED BY SIZE
                FUNCTION TRIM(FD-EMAIL) DELIMITED BY SPACE
                '", '           DELIMITED BY SIZE
                '"Saldo": '     DELIMITED BY SIZE
                FUNCTION TRIM(WS-BALANCE-FORMATTED) DELIMITED BY SIZE
                '}'             DELIMITED BY SIZE
                INTO REG-OUT
           END-STRING.

           WRITE REG-OUT.
    .
       300-CLOSE-JSON.
           IF WK-FIRST-RECORD = 'N'
               MOVE ' ' TO REG-OUT
               WRITE REG-OUT
           END-IF

           MOVE ']}' TO REG-OUT
           WRITE REG-OUT.

       400-CONVERT-BALANCE.
           INSPECT FD-BALANCE REPLACING ALL ',' BY '.'.
           MOVE FUNCTION NUMVAL(FD-BALANCE) TO WS-BALANCE-NUM.
           MOVE WS-BALANCE-NUM TO WS-BALANCE-FORMATTED.

       900-CLOSE-DATA.
           CLOSE ARQIN.
           CLOSE ARQOUT.
    .

       END PROGRAM FIXED-FORMAT-TO-JSON.
