CREATE OR REPLACE function tf_emp_pl RETURN ntt_emp pipelined
IS
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
    FROM employees
  )
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

    SELECT count(*) INTO v_count_emp_dep
    FROM employees
    WHERE department_id = rec.department_id;

    PIPE ROW (o_emp(rec.employee_id,
      rec.first_name || ' ' || rec.last_name, v_count_orders,
      v_max_sales, rec.department_id, v_dep, v_count_emp_dep));
  END LOOP;

  RETURN;
END;
/

SELECT *
FROM TABLE(tf_emp_pl);