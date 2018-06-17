-- Serveroutput
SET serveroutput ON;

-- Procedure
CREATE OR REPLACE PROCEDURE dropTableLike(i_likeIdentifier IN VARCHAR2) AS
  v_tblName user_tables.table_name%TYPE;
  curLikeTables SYS_REFCURSOR;
BEGIN
  -- create cursor
  OPEN curLikeTables FOR 'SELECT table_name FROM user_tables WHERE table_name LIKE :table_name' USING i_likeIdentifier;

  -- iterate with cursor
  LOOP
    FETCH curLikeTables INTO v_tblName;
    EXIT WHEN curLikeTables%NOTFOUND;
    EXECUTE IMMEDIATE 'DROP TABLE ' || v_tblName || ' PURGE';
  END LOOP;

  -- close cursor
  CLOSE curLikeTables;
EXCEPTION
  WHEN OTHERS THEN
    RAISE_APPLICATION_ERROR(-20000, 'Something went wrong! ' || SQLERRM());
END;
/

-- Execure procedure
EXEC dropTableLike('TMP_%');