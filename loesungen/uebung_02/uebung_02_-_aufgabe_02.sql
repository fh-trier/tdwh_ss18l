-- Objekt: Channel
CREATE OR REPLACE TYPE obj_channel AS OBJECT (
  CHANNEL_CLASS_ID  NUMBER,
  CHANNEL_CLASS     VARCHAR2(20),
  CHANNEL_ID        NUMBER,
  CHANNEL_DESC      VARCHAR2(20),
  COUNT_ORDERS      NUMBER,
  AVG_ORDER_TOTAL   NUMBER(38,2)
);

-- NestedTable: Channels
CREATE OR REPLACE TYPE nt_channels AS TABLE OF obj_channel;

-- Function: func_channel
CREATE OR REPLACE FUNCTION func_channel(in_channel_class_id NUMBER) RETURN nt_channels
AS

  listChannels nt_channels := nt_channels();

  CURSOR curChannels IS
    SELECT  c.channel_class_id,
            c.channel_class,
            c.channel_id,
            c.channel_desc,
            (
              SELECT  COUNT(order_id)
              FROM orders
              WHERE channel_id = c.channel_id
            ) AS "COUNT_ORDERS",
            (
              SELECT ROUND(AVG(SUM(unit_price * quantity)),2) AS durchschnitt
              FROM orders o
                INNER JOIN order_items oi ON o.order_id = oi.order_id
              WHERE channel_id = c.channel_id
              GROUP BY o.order_id
            ) AS "AVG_ORDER_TOTAL"
    FROM    channels c
    WHERE   c.channel_class_id = in_channel;

  vLoopIndex NUMBER(1) := 1;

BEGIN
  FOR recChannel IN curChannels LOOP
    listChannels.EXTEND;
    listChannels(vLoopIndex) := recChannel;
    vLoopIndex:= vLoopIndex + 1;
  END LOOP;
END;
/

-- Abfrage
SELECT *
FROM TABLE(func_channel());