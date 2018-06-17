UPDATE GehegeMitarbeiter
SET Mitarbeiternr = (
  SELECT Mitarbeiternr
  FROM Mitarbeiter
  WHERE UPPER(Vorname) = UPPER('Elvira')
  AND UPPER(Nachname) = UPPER('Huhn'))
WHERE Mitarbeiternr = (
  SELECT Mitarbeiternr
  FROM Mitarbeiter
  WHERE UPPER(Vorname) = UPPER('Peter')
  AND UPPER(Nachname) = UPPER('Dallmann')
);

COMMIT;