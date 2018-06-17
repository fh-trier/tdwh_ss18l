SELECT
  m.firstname,
  m.lastname,
  COUNT(m.quant)
FROM
  weborders,
  JSON_TABLE(jsonord, '$' COLUMNS
    firstname VARCHAR2(30) PATH '$.firstname',
    lastname VARCHAR2(30) PATH '$.lastname',
    NESTED PATH '$.items[*]' COLUMNS (
      quant NUMBER(8) PATH '$.quantity'
    )
  ) m
GROUP BY firstname, lastname;