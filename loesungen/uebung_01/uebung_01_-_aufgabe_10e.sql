SELECT *
FROM mitarbeiter
WHERE gehalt = (
  SELECT MAX(gehalt)
  FROM mitarbeiter
);