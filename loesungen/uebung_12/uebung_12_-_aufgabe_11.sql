CREATE OR REPLACE procedure p_dynsql (i_name IN VARCHAR2)
IS
  v_name VARCHAR2(255);
  cur_tab sys_refcursor;
BEGIN
  OPEN cur_tab FOR 'SELECT CUST_FIRST_NAME || '' '' || CUST_LAST_NAME
    FROM customers
    WHERE UPPER(CUST_FIRST_NAME || '' '' || CUST_LAST_NAME) LIKE :a' USING UPPER(i_name);

  LOOP
    FETCH cur_tab INTO v_name;
    EXIT WHEN cur_tab%NOTFOUND;

    DBMS_OUTPUT.PUT_LINE(v_name);
  END LOOP;
END;
/

SET serveroutput ON
EXEC p_dynsql('%cl%');