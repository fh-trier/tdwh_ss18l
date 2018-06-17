CREATE OR REPLACE FUNCTION tf_prod_p(c_orders IN SYS_REFCURSOR) RETURN nt_prod_t pipelined
IS
  r_orders orders%ROWTYPE;

  v_anz_pos NUMBER;
  v_channel VARCHAR2(50);
  v_customer VARCHAR2(50);
BEGIN
  LOOP
    FETCH c_orders INTO r_orders;
    EXIT WHEN c_orders%NOTFOUND;

    SELECT COUNT(*) INTO v_anz_pos
    FROM order_items
    WHERE order_id = r_orders.order_id;

    SELECT CHANNEL_DESC into v_channel
    FROM channels
    WHERE channel_id = r_orders.channel_id;

    SELECT cust_first_name into v_customer
    FROM customers
    WHERE customer_id = r_orders.customer_id;

    PIPE ROW (o_prod(
      r_orders.order_id,
      r_orders.order_date,
      v_anz_pos,
      v_channel,
      v_customer
    ));
  END LOOP;

  CLOSE c_orders;
  RETURN;
END;
/