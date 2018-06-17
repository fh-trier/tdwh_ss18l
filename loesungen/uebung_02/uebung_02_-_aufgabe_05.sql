-- Prozedur zum erzeugen vom tmp Tabellen
CREATE OR REPLACE PROCEDURE creTmpTable AS
BEGIN
  FOR rec IN (
    SELECT tname
    FROM tab
    WHERE NOT REGEXP_LIKE(tname, '^BIN\$.*$', 'i'))
  LOOP
    EXECUTE IMMEDIATE 'CREATE TABLE tmp_' || rec.tname || ' AS SELECT * FROM ' || rec.tname;
  END LOOP;
EXCEPTION
  WHEN OTHERS THEN
    RAISE_APPLICATION_ERROR(-20000, 'Error: ' || SQLERRM());
END;
/

-- Ausführen der Prozedur
EXEC creTmpTable();
/

-- Exkurs
-- Prozedur zum löschen vom tmp Tabellen
CREATE OR REPLACE PROCEDURE dropTmpTable AS
BEGIN
  FOR rec IN (
    SELECT tname
    FROM tab
    WHERE REGEXP_LIKE(tname, '^TMP_.*$', 'i'))
  LOOP
    EXECUTE IMMEDIATE 'DROP TABLE ' || rec.tname || ' PURGE';
  END LOOP;
EXCEPTION
  WHEN OTHERS THEN
    RAISE_APPLICATION_ERROR(-20000, 'Error: ' || SQLERRM());
END;
/

-- Ausführen der Prozedur
EXEC dropTmpTable();
/
