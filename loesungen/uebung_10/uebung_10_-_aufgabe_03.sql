SELECT 
  jt.ACTIVE, 
  SUM(jt.quant)
FROM 
  weborders, 
  JSON_TABLE(jsonord, '$' COLUMNS
    active VARCHAR2(30) PATH '$.active',
    NESTED PATH '$.items[*]' COLUMNS (
      quant NUMBER(8) PATH '$.quantity'
    )
  ) jt
GROUP BY ROLLUP(jt.active);