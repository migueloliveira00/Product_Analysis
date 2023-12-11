-- This is a SQL query demonstrating the use of a CTE (common table expression) to show the top 5 customers in each country in the dataset

WITH  top_5_customers (first_name, last_name, customer_id, country, city, total_amount_paid) AS 
        (SELECT A.first_name, A.last_name, A.customer_id, D.country, C.city,
	   		      SUM(E.amount) AS "total_amount_paid"
      	FROM customer A
	      INNER JOIN address B ON A.address_id = B.address_id
      	INNER JOIN city C ON B.city_id = C.city_id
      	INNER JOIN country D ON C.country_id = D.country_id 
      	INNER JOIN payment E ON A.customer_id = E.customer_id
      	WHERE city IN ('Aurora', 'Acua', 'Citrus Heights', 'Iwaki', 'Ambattur', 'Shanwei',
			           'So Leopoldo', 'Tianjin', 'Hami', 'Cianjur')	
GROUP BY A.customer_id, first_name, last_name, country, city
	ORDER BY "total_amount_paid" DESC
	LIMIT 5)
SELECT D.country, COUNT(A.customer_id) AS all_customer_count, 
COUNT(top_5_customers) AS top_customer_count
FROM customer A
INNER JOIN address B ON A.address_id = B.address_id
INNER JOIN city C ON B.city_id = C.city_id
INNER JOIN country D ON C.country_id = D.country_id
LEFT JOIN top_5_customers
ON A.customer_id = top_5_customers.customer_id
GROUP BY D.country
HAVING COUNT (top_5_customers) > 0
ORDER BY (top_5_customers), COUNT(A.customer_id) DESC
