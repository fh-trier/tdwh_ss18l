SELECT
  m.*
FROM
  weborders,
  JSON_TABLE(jsonord, '$' COLUMNS
    last VARCHAR2(30) PATH '$.lastname',
    gend VARCHAR2(30) PATH '$.gender',
    phone VARCHAR2(30) PATH '$.phone',
    NESTED PATH '$.items[*]' COLUMNS (
      prod_id NUMBER(8) PATH '$.product_id',
      quant NUMBER(8) PATH '$.quantity'
    )
  ) m;