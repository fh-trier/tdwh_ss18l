SELECT
  monat,
  umsatz, 
  SUM(umsatz) OVER(ORDER BY monat ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS "LAUFENDE_SUMME",
  AVG(umsatz) OVER(ORDER BY monat ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING) AS "AVG"
FROM (
  SELECT 
    TO_CHAR(o.order_date, 'YYYY-MM') AS "MONAT",
    SUM(o.order_total) AS "UMSATZ"
  FROM orders o
  WHERE EXTRACT(YEAR FROM o.order_date) = '2007'
  GROUP BY TO_CHAR(o.order_date, 'YYYY-MM')
);
