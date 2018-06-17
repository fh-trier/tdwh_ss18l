DROP function tf_emp;
DROP TYPE ntt_emp;
DROP TYPE o_emp;

CREATE TYPE o_emp AS object
(
  emp_id NUMBER,
  emp VARCHAR2(255),
  count_orders NUMBER,
  max_sales NUMBER,
  depid NUMBER,
  dep VARCHAR2(255),
  count_emp_dep NUMBER
);
/

CREATE TYPE ntt_emp AS TABLE OF o_emp;
/

CREATE OR REPLACE function tf_emp RETURN ntt_emp
IS
  nt_emp ntt_emp := ntt_emp();
  v_count_orders NUMBER;
  v_max_sales NUMBER;
  v_dep VARCHAR2(255);
  v_count_emp_dep NUMBER;
BEGIN
  FOR rec IN (
    SELECT
      employee_id,
      first_name,
      last_name,
      department_id
    FROM employees)
  LOOP
    SELECT
      COUNT(*),
      MAX(order_total)
    INTO
      v_count_orders,
      v_max_sales
    FROM orders
    WHERE sales_rep_id = rec.employee_id;

    SELECT department_name INTO v_dep
    FROM departments
    WHERE department_id = rec.department_id;

    SELECT COUNT(*) INTO v_count_emp_dep
    FROM employees
    WHERE department_id = rec.department_id;

    nt_emp.extend();
    nt_emp(nt_emp.lASt) := o_emp(rec.employee_id,
      rec.first_name || ' ' || rec.lASt_name, v_count_orders,
      v_max_sales, rec.department_id, v_dep, v_count_emp_dep);
  END LOOP;

  RETURN nt_emp;
END;
/

SELECT *
FROM TABLE(tf_emp);