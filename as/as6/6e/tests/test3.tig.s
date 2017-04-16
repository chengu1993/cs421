MOVE(
 TEMP T100,
 ESEQ(
  MOVE(
   MEM[4](
    BINOP(PLUS,
     TEMP T101,
     CONST 128)),
   ESEQ(
    SEQ(
     MOVE(
      TEMP T105,
      CALL(
       NAME allocRecord,
        CONST 8)),
     SEQ(
      MOVE(
       MEM[4](
        BINOP(PLUS,
         TEMP T105,
         CONST 0)),
       NAME L0),
      MOVE(
       MEM[4](
        BINOP(PLUS,
         TEMP T105,
         CONST 4)),
       CONST 1000))),
    TEMP T105)),
  ESEQ(
   MOVE(
    ESEQ(
     EXP(
      CALL(
       NAME checkNilRecord,
        MEM[4](
         BINOP(PLUS,
          TEMP T101,
          CONST 128)))),
     MEM[4](
      BINOP(PLUS,
       MEM[4](
        BINOP(PLUS,
         TEMP T101,
         CONST 128)),
       BINOP(MUL,
        CONST 0,
        CONST 4)))),
    NAME L1),
   ESEQ(
    EXP(
     MEM[4](
      BINOP(PLUS,
       TEMP T101,
       CONST 128))),
    CONST 1))))
