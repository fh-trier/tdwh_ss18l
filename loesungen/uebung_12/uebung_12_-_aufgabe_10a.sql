DROP function tdwh_12_10a_func;
DROP TYPE tdwh_12_10a_nt;
DROP TYPE tdwh_12_10a_ob;

CREATE TYPE tdwh_12_10a_ob AS object
(
  "EMP_ID" NUMBER,
  "EMP_NAME" VARCHAR2(255),
  "COUNT_ORDERS" NUMBER,
  "MAX_SALES" NUMBER,
  "DEPT_ID" NUMBER,
  "DEPT_NAME" VARCHAR2(255),
  "COUNT_EMP_DEPT" NUMBER
);
/

CREATE TYPE tdwh_12_10a_nt AS TABLE OF tdwh_12_10a_ob;
/

CREATE OR REPLACE FUNCTION tdwh_12_10a_func RETURN tdwh_12_10a_nt
IS
  ntEmployee tdwh_12_10a_nt := tdwh_12_10a_nt();
  vCountOrders NUMBER;
  vMaxSales NUMBER;
  vDeptName VARCHAR2(255);
  vCountEmpDept NUMBER;
BEGIN
  FOR rec IN (
    SELECT
      e.employee_id,
      e.first_name,
      e.last_name,
      e.department_id
    FROM employees e
  )
  LOOP
    -- Max Bestellumsatz
    SELECT
      NVL(MAX(o.order_total),0)
    INTO
      vMaxSales
    FROM orders o
    WHERE o.sales_rep_id = rec.employee_id;

    -- Anzahl Bestellungen
    SELECT
      COUNT(*)
    INTO
      vCountOrders
    FROM orders o
    WHERE o.sales_rep_id = rec.employee_id;

    -- Department
    SELECT d.department_name INTO vDeptName
    FROM departments d
    WHERE d.department_id = rec.department_id;

    -- Anzahl Mitarbeiter im Department
    SELECT COUNT(*) INTO vCountEmpDept
    FROM employees e
    WHERE e.department_id = rec.department_id;

    DBMS_OUTPUT.PUT_LINE(' ' || ntEmployee.LAST);

    ntEmployee.EXTEND();
    ntEmployee(ntEmployee.LAST) := tdwh_12_10a_ob(
      rec.employee_id,
      rec.first_name || ' ' || rec.last_name,
      vCountOrders,
      vMaxSales,
      rec.department_id,
      vDeptName,
      vCountEmpDept
    );
  END LOOP;

  RETURN ntEmployee;
END;
/

SET SERVEROUTPUT ON;

SELECT *
FROM TABLE(tdwh_12_10a_func());