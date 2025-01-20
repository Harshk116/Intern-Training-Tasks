-- 1.  Write a query to Display the product details (product_class_code, product_id, product_desc, product_price,) as per the following criteria and sort them in descending order of category: a. If the category is 2050, increase the price by 2000 b. If the category is 2051, increase the price by 500 c. If the category is 2052, increase the price by 600. Hint: Use case statement. no permanent change in table required. (60 ROWS) [NOTE: PRODUCT TABLE]
SELECT 
    product_class_code,
    product_id,
    product_desc,
    CASE 
        WHEN product_class_code = 2050 THEN product_price + 2000
        WHEN product_class_code = 2051 THEN product_price + 500
        WHEN product_class_code = 2052 THEN product_price + 600
        ELSE product_price
    END AS updated_price
FROM product
ORDER BY product_class_code DESC;
-- 2.  Write a query to display (product_class_desc, product_id, product_desc, product_quantity_avail ) and Show inventory status of products as below as per their available quantity: a. For Electronics and Computer categories, if available quantity is <= 10, show 'Low stock', 11 <= qty <= 30, show 'In stock', >= 31, show 'Enough stock' b. For Stationery and Clothes categories, if qty <= 20, show 'Low stock', 21 <= qty <= 80, show 'In stock', >= 81, show 'Enough stock' c. Rest of the categories, if qty <= 15 – 'Low Stock', 16 <= qty <= 50 – 'In Stock', >= 51 – 'Enough stock' For all categories, if available quantity is 0, show 'Out of stock'. Hint: Use case statement. (60 ROWS) [NOTE: TABLES TO BE USED – product, product_class]
SELECT 
    pc.product_class_desc,
    p.product_id,
    p.product_desc,
    p.product_quantity_avail,
    CASE 
        WHEN pc.product_class_desc IN ('Electronics', 'Computer') AND p.product_quantity_avail = 0 THEN 'Out of stock'
        WHEN pc.product_class_desc IN ('Electronics', 'Computer') AND p.product_quantity_avail <= 10 THEN 'Low stock'
        WHEN pc.product_class_desc IN ('Electronics', 'Computer') AND p.product_quantity_avail BETWEEN 11 AND 30 THEN 'In stock'
        WHEN pc.product_class_desc IN ('Electronics', 'Computer') AND p.product_quantity_avail >= 31 THEN 'Enough stock'
        WHEN pc.product_class_desc IN ('Stationery', 'Clothes') AND p.product_quantity_avail = 0 THEN 'Out of stock'
        WHEN pc.product_class_desc IN ('Stationery', 'Clothes') AND p.product_quantity_avail <= 20 THEN 'Low stock'
        WHEN pc.product_class_desc IN ('Stationery', 'Clothes') AND p.product_quantity_avail BETWEEN 21 AND 80 THEN 'In stock'
        WHEN pc.product_class_desc IN ('Stationery', 'Clothes') AND p.product_quantity_avail >= 81 THEN 'Enough stock'
        WHEN p.product_quantity_avail = 0 THEN 'Out of stock'
        WHEN p.product_quantity_avail <= 15 THEN 'Low stock'
        WHEN p.product_quantity_avail BETWEEN 16 AND 50 THEN 'In stock'
        WHEN p.product_quantity_avail >= 51 THEN 'Enough stock'
    END AS inventory_status
FROM product p
JOIN product_class pc ON p.product_class_code = pc.product_class_code;
