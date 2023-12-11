-- Query to extract the 5 top performing movies in the database based on revenue using INNER JOIN

SELECT Film.title, Category.name,
SUM(Payment.amount) AS Total_Revenue
FROM Film
INNER JOIN Inventory ON Inventory.film_id = Film.film_id
INNER JOIN Rental ON Inventory.inventory_id = Rental.inventory_id
INNER JOIN Payment ON Rental.rental_id = Payment.rental_id
INNER JOIN Film_Category ON Film.film_id = Film_Category.film_id
INNER JOIN Category ON Film_Category.category_id = Category.category_id
GROUP BY Film.title, Category.name
ORDER BY SUM(Payment.amount) DESC
LIMIT 5
