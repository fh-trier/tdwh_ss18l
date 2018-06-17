CREATE OR REPLACE TYPE o_cust AS object (
  cust_id INTEGER,
  gesamt_umsatz NUMBER
);
/

CREATE OR REPLACE TYPE nt_cust AS TABLE OF o_cust;
/

CREATE OR REPLACE FUNCTION tf_cust_umsatz RETURN nt_cust pipelined
AS
  CURSOR cur IS
    SELECT
      cust_id,
      SUM(
        NVL(amount_sold,0) +
        NVL(amount_sold1,0) +
        NVL(amount_sold2,0) +
        NVL(amount_sold3,0)
      ) ges_umsatz
    FROM salesExternal
    GROUP BY cust_id;
BEGIN
  FOR rec IN cur LOOP
    PIPE ROW (o_cust(rec.cust_id, rec.ges_umsatz));
  END LOOP;
END;
/

SELECT *
FROM table(tf_cust_umsatz);