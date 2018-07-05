CREATE OR REPLACE VIEW "TDWH_10_02" AS
SELECT
  jt.*
FROM
  weborders w,
  JSON_TABLE(
    w.JSONORD, '$' COLUMNS (
      "LAST" VARCHAR2(30) PATH '$.lastname',
      "GENDER" VARCHAR2(30) PATH '$.gender',
      "PHONE" VARCHAR2(30) PATH '$.phone',
      NESTED PATH '$.items[*]' COLUMNS(
        "PROD_ID" VARCHAR2(30) PATH '$.product_id',
        "QUANT" VARCHAR2(30) PATH '$.quantity'
      )
    )
  ) jt;
