-- Drop old types
DROP TYPE t_customer;
DROP TYPE o_customer;

-- create or replace type
CREATE OR REPLACE TYPE o_customer AS OBJECT (
  customer_id NUMBER,
  name VARCHAR2(100),
  country VARCHAR2(50),
  order_total NUMBER
);
/

-- create type as table of
CREATE OR REPLACE TYPE t_customer AS TABLE OF o_customer;
/

-- create procedure
CREATE OR REPLACE function tf_customer (i_cur_cust IN sys_refcursor) RETURN t_customer
AS
  l_customer t_customer := t_customer();
  rec_cust customers%ROWTYPE;
  v_country countries.country_name%TYPE;
  v_order_total NUMBER;
BEGIN
  LOOP
    FETCH i_cur_cust INTO rec_cust;
    EXIT WHEN i_cur_cust%NOTFOUND;

    SELECT SUM(order_total) INTO v_order_total
    FROM orders
    WHERE customer_id = rec_cust.customer_id;

    SELECT country_name INTO v_country
    FROM countries
    WHERE country_id = rec_cust.country_id;

    l_customer.EXTEND;
    l_customer(l_customer.LAST) := o_customer(
      rec_cust.customer_id,
      rec_cust.cust_last_name || ', ' || rec_cust.cust_first_name,
      v_country,
      NVL(v_order_total, 0)
    );
  END LOOP;

  CLOSE i_cur_cust;

  RETURN l_customer;

EXCEPTION
  WHEN OTHERS THEN
    RAISE_APPLICATION_ERROR(-20000, 'Error: ' || SUBSTR(sqlerrm, 1, 200));
END;
/

-- Execute table function
SELECT *
FROM TABLE(
  tf_customer(
    CURSOR(
      SELECT *
      FROM customers
      WHERE customer_id < 200
    )
  )
);