-- Subquery used to extract the average amount paid by the top 5 customers from the dataset

SELECT customer_id,
       first_name,
       last_name
       AVG(total_count_paid.average_amount) AS average_amount_paid
FROM
(SELECT customer.customer_id,
        customer.first_name,
        customer.last_name,
        country.country,
        city.city,
        SUM(amount) AS Total_Amount_Paid,
        AVG(amount) AS Average_Amount
FROM country
INNER JOIN city ON country.country_id = city.country_id
INNER JOIN address ON city.city_id = address.city_id
INNER JOIN customer ON customer.address_id = address.address_id
INNER JOIN payment ON payment.customer_id = customer.customer_id
WHERE country IN ('India', 'China', 'United States', 'Japan', 'Mexico', 'Brazil', 'Russian Federation', 'Philippines', 'Turkey', 'Indonesia')
GROUP BY 1, 2, 3, 4, 5
ORDER BY 6 DESC
LIMIT 5) AS total_amount_paid
GROUP BY 1, 2, 3
ORDER BY 4 DESC
