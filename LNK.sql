use project2;

--- 1. Total Sales Per City
SELECT 
	city, 
	CONCAT('Rp ', FORMAT(SUM(Quantity*Unit_Price),0)) as Total_Sales_per_City
FROM
	sales s JOIN outlet o
    ON s.Outlet_ID = o.outlet_id
GROUP BY
	city;

--- 2. Total Sales by Trade

SELECT 
	Trade, 
    CONCAT('Rp ', FORMAT(SUM(Quantity*Unit_Price),0)) as Total_Sales_per_Trade
FROM
	sales
GROUP BY
	Trade;
    
--- 3. Total Sales by MONTHNAME (desc order by total sales per month)

SELECT 
    MONTHNAME(Date) AS Month,
    CONCAT('Rp ', FORMAT(SUM(Quantity * Unit_Price), 0)) AS Total_Sales_per_Month
FROM 
    sales
GROUP BY 
    MONTHNAME(Date)
ORDER BY 
    SUM(Quantity * Unit_Price) DESC;
    
--- 4. Total Sales by Outlet Type (desc order)

SELECT
	outlet_type,
    CONCAT('Rp ', FORMAT(SUM(Quantity*Unit_Price),0)) as Total_sales_by_Outlet
FROM
	sales s JOIN outlet o
    ON s.Outlet_ID = o.outlet_id
GROUP BY
	outlet_type
ORDER BY
	SUM(Quantity*Unit_Price) DESC;
    
-- 5. Payment Method used by Customer

SELECT 
	Payment_Method,
    COUNT(Payment_Method)
FROM 
	sales
GROUP BY 
	Payment_Method
ORDER BY 
	COUNT(Payment_Method) DESC;
    
    
--- 6. Total sales Promotional vs Non Promotional

SELECT
	CASE 
		WHEN Promo_Applied ='Yes' THEN 'With Promo'
		WHEN Promo_Applied ='No' THEN 'Without Promo'
        ELSE Promo_Applied
	END AS Promo_status,
	CONCAT('Rp ', FORMAT(SUM(Quantity*Unit_Price),0)) AS Total_Sales
FROM
	sales
GROUP BY
	CASE 
		WHEN Promo_Applied ='Yes' THEN 'With Promo'
		WHEN Promo_Applied ='No' THEN 'Without Promo'
        ELSE Promo_Applied
	END
ORDER BY
	SUM(Quantity*Unit_Price) DESC;
    
--- 7. Best selling products (all)

SELECT
	product_name,
	SUM(Quantity) AS number_of_product_sold
FROM
	sales s JOIN product p
    ON s.product_id = p.product_id
GROUP BY 
	product_name
ORDER BY
	SUM(Quantity) DESC;

--- 8. Best selling product (MT)
SELECT
	product_name,
	SUM(Quantity)
FROM
	sales s JOIN product p
    ON s.product_id = p.product_id
WHERE
	Trade = 'Modern Trade'
GROUP BY 
	product_name
ORDER BY
	SUM(Quantity) DESC;
    
--- 9. Best selling product (GT)
SELECT
	product_name,
	SUM(Quantity)
FROM
	sales s JOIN product p
    ON s.product_id = p.product_id
WHERE
	Trade = 'General Trade'
GROUP BY 
	product_name
ORDER BY
	SUM(Quantity) DESC;
    
--- 10. Month with highest transaction (2023)

SELECT 
	MONTHNAME(Date) AS Month,
    COUNT(Transaction_ID) AS Freq_transaction
FROM
	sales
WHERE
	YEAR(Date) ='2023'
GROUP BY
	MONTHNAME(Date)
ORDER BY
	Freq_transaction DESC;

--- 11. Month with highest transaction (2024)

SELECT 
	MONTHNAME(Date) AS Month,
    COUNT(Transaction_ID) AS Freq_transaction
FROM
	sales
WHERE
	YEAR(Date) ='2024'
GROUP BY
	MONTHNAME(Date)
ORDER BY
	Freq_transaction DESC;
    
--- 12. Best Selling Outlet (GT)

SELECT
	outlet_name,
    CONCAT('Rp ', FORMAT(SUM(Quantity*Unit_Price),0)) AS Total_Sales
FROM
	sales s JOIN outlet o
    ON s.Outlet_ID = o.outlet_id
WHERE
	Trade = 'General Trade'
GROUP BY
	outlet_name
ORDER BY
	SUM(Quantity*Unit_Price) DESC;

--- 13. Best Selling Outlet (MT)

SELECT
	outlet_name,
    CONCAT('Rp ', FORMAT(SUM(Quantity*Unit_Price),0)) AS Total_Sales
FROM
	sales s JOIN outlet o
    ON s.Outlet_ID = o.outlet_id
WHERE
	Trade = 'Modern Trade'
GROUP BY
	outlet_name
ORDER BY
	SUM(Quantity*Unit_Price) DESC;


--- 14. Numbers of outlet by City

SELECT
	city, COUNT(outlet_id) as numbers_of_outlet
FROM
	outlet
GROUP BY
	city;

--- 15. Best Employee based on total sales

SELECT
	Employee_Name,
    CONCAT('Rp ', FORMAT(SUM(Quantity*Unit_Price),0)) AS Total_Sales
FROM 
	employee e JOIN sales s
    ON e.Employee_ID = s.Employee_ID
GROUP BY
	Employee_Name
ORDER BY
	SUM(Quantity*Unit_Price) DESC;
     
--- 16. Total Sales by Distributor

SELECT 
	Distributor_Name,
    CONCAT('Rp ', FORMAT(SUM(Quantity*Unit_Price),0)) AS Total_Sales
FROM
	distributor d JOIN sales s
    ON d.Distributor_ID = s.Distributor_ID
GROUP BY
	Distributor_Name
ORDER BY
	SUM(Quantity*Unit_Price) DESC;

--- 17. Trade and Distributor Type

SELECT 
    Trade,
    Distributor_Type,
    COUNT(DISTINCT Outlet_ID) AS Outlet_Count
FROM
    sales s 
JOIN 
    distributor d 
    ON 
    s.Distributor_ID = d.Distributor_ID
GROUP BY
    Trade,
    Distributor_Type;
    
--- 18. Number of Distributor per City

SELECT 
	DISTINCT Distributor_Name,
	COUNT(DISTINCT city) AS Numbers_of_city_provided
FROM
	outlet o 
		JOIN sales s
		ON o.outlet_id = s.Outlet_ID
		JOIN distributor d 
        ON d.Distributor_ID =s.Distributor_ID
GROUP BY
	Distributor_Name;
    

--- 19. Number of Outlet per distributor type

SELECT
	Distributor_Type,
    COUNT(DISTINCT o.Outlet_Name) AS numbers_of_outlet
FROM
outlet o 
		JOIN sales s
		ON o.outlet_id = s.Outlet_ID
		JOIN distributor d 
        ON d.Distributor_ID =s.Distributor_ID
GROUP BY 
	Distributor_Type;


