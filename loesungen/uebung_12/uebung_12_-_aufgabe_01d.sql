SELECT *
FROM (
  SELECT
    prod_id,
    SUM(
      NVL(amount_sold,0) +
      NVL(amount_sold1,0) +
      NVL(amount_sold2,0) +
      NVL(amount_sold3,0)
    ) umsatz,
    RANK() OVER(
      ORDER BY SUM(
        NVL(amount_sold,0) +
        NVL(amount_sold1,0) +
        NVL(amount_sold2,0) +
        NVL(amount_sold3,0)
      )
    ) rang
  FROM salesExternal
  GROUP BY prod_id
)
WHERE rang < 3;