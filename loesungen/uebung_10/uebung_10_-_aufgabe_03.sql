CREATE OR REPLACE VIEW "TDWH_10_03" AS
SELECT
  jt.active AS "ACTIVE",
  SUM(jt.quantity) AS "SUM_QUANT"
FROM
  weborders w,
  JSON_TABLE(
    w.JSONORD, '$' COLUMNS (
      "ACTIVE" VARCHAR2(30) PATH '$.active',
      NESTED PATH '$.items[*]' COLUMNS (
        "QUANTITY" VARCHAR2(30) PATH '$.quantity'
      )
    )
  ) jt
GROUP BY GROUPING SETS(
  (jt.active),
  ()
);
