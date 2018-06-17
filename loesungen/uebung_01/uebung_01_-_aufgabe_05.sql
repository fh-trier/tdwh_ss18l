INSERT INTO Tiere
VALUES(
  (
    SELECT
      MAX(Tiernr) + 1
    FROM
      Tiere
  ),
  'Lotta',
  'Krokodil',
  SYSDATE - INTERVAL '5' DAY,
  (
    SELECT
      Futtertyp
    FROM
      futter
    WHERE UPPER(Bezeichnung) = UPPER('Fleisch')
  )
);

INSERT INTO Gehegetiere
VALUES (
  120,
  10,
  SYSDATE
);