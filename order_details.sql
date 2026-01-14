SELECT * FROM order_details;

SELECT * 
FROM order_details
ORDER BY order_date DESC;

SELECT COUNT(DISTINCT order_id) AS total_num_order
FROM order_details;

SELECT COUNT(*) 
FROM order_details;

SELECT order_id, COUNT(item_id) AS num_items
FROM order_details
GROUP BY order_id
ORDER BY num_items DESC;

SELECT COUNT(*) 
FROM
(SELECT order_id, COUNT(item_id) AS num_items
FROM order_details
GROUP BY order_id
HAVING num_items > 12) AS num_orders;