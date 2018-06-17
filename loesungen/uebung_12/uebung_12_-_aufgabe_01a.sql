DROP TABLE salesExternal;

CREATE TABLE salesExternal(
  PROD_ID           INTEGER,
  CUST_ID           INTEGER,
  TIME_ID           DATE,
  CHANNEL_ID        CHAR(1),
  PROMO_ID          INTEGER,
  QUANTITY_SOLD     INTEGER,
  AMOUNT_SOLD       NUMBER(10,2),
  QUANTITY_SOLD1    INTEGER,
  AMOUNT_SOLD1      NUMBER(10,2),
  QUANTITY_SOLD2    INTEGER,
  AMOUNT_SOLD2      NUMBER(10,2),
  QUANTITY_SOLD3    INTEGER,
  AMOUNT_SOLD3      NUMBER(10,2)
)
ORGANIZATION EXTERNAL(
  TYPE oracle_loader
  DEFAULT directory student_dir
  ACCESS PARAMETERS(
    RECORDS DELIMITED BY NEWLINE
    NOBADFILE NOLOGFILE NODISCARDFILE
    FIELDS TERMINATED BY ';'
    MISSING FIELD VALUES ARE NULL
  )
  LOCATION ('sales4.dat')
)
REJECT LIMIT UNLIMITED;

SELECT *
FROM salesExternal;