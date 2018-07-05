CREATE OR REPLACE VIEW "TDWH_10_01B" AS
SELECT
  jt.*
FROM
  weborders w,
  JSON_TABLE(
    w.JSONORD, '$' COLUMNS (
      "FIRST" VARCHAR2(30) PATH '$.firstname',
      "LAST" VARCHAR2(30) PATH '$.lastname',
      "GENDER" VARCHAR2(30) PATH '$.gender',
      "PHONE" VARCHAR2(30) PATH '$.phone',
      "REGISTRED" VARCHAR2(30) PATH '$.registered'
    )
  ) jt;
