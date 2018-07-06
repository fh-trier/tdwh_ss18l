SELECT *
FROM (
  SELECT
    t.prod_id AS "PRODUCT_ID",
    SUM(
      NVL(t.quantity_sold0, 0) * NVL(t.amount_sold0, 0) +
      NVL(t.quantity_sold1, 0) * NVL(t.amount_sold1, 0) +
      NVL(t.quantity_sold2, 0) * NVL(t.amount_sold2, 0) +
      NVL(t.quantity_sold3, 0) * NVL(t.amount_sold3, 0)
    ) AS "UMSATZ",
    RANK() OVER(
      ORDER BY SUM(
        NVL(t.quantity_sold0, 0) * NVL(t.amount_sold0, 0) +
        NVL(t.quantity_sold1, 0) * NVL(t.amount_sold1, 0) +
        NVL(t.quantity_sold2, 0) * NVL(t.amount_sold2, 0) +
        NVL(t.quantity_sold3, 0) * NVL(t.amount_sold3, 0)
      ) ASC
    ) AS "RANG"
  FROM tdwh_12_01 t
  GROUP BY t.prod_id
)
WHERE rang <= 2;
