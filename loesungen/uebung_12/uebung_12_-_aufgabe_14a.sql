DROP FUNCTION tf_prod;
DROP TYPE nt_prod;
DROP TYPE o_prod;

CREATE TYPE o_prod AS object (
  order_id NUMBER,
  order_date DATE,
  anz_positionen NUMBER,
  channel VARCHAR2(50),
  customer VARCHAR2(50)
);
/

CREATE TYPE nt_prod_t IS TABLE OF o_prod;
/

CREATE OR REPLACE FUNCTION tf_prod(c_orders IN SYS_REFCURSOR) RETURN nt_prod_t
IS
  nt_prod nt_prod_t := nt_prod_t();
  r_orders orders%ROWTYPE;

  v_anz_pos NUMBER;
  v_channel VARCHAR2(50);
  v_customer VARCHAR2(50);
BEGIN
  LOOP
    FETCH c_orders INTO r_orders;
    EXIT WHEN c_orders%NOTFOUND;

    SELECT count(*) INTO v_anz_pos
    FROM order_items
    where order_id = r_orders.order_id;

    SELECT CHANNEL_DESC INTO v_channel
    FROM channels
    where channel_id = r_orders.channel_id;

    SELECT cust_first_name INTO v_customer
    FROM customers
    where customer_id = r_orders.customer_id;

    nt_prod.EXTEND();
    nt_prod(nt_prod.LAST) := o_prod(
      r_orders.order_id,
      r_orders.order_date,
      v_anz_pos,
      v_channel,
      v_customer
    );
  END LOOP;

  CLOSE c_orders;
  RETURN nt_prod;
END;
/