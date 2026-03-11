/*
 * Select the titles of all films that the customer with customer_id=1 has rented more than 1 time.
 *
 * HINT:
 * It's possible to solve this problem both with and without subqueries.
 */

SELECT
    f.title
FROM film AS f
JOIN inventory AS i
    ON f.film_id = i.film_id
JOIN rental AS r
    ON i.inventory_id = r.inventory_id
JOIN customer AS c
    ON r.customer_id = c.customer_id
WHERE c.customer_id =1
GROUP BY f.title
HAVING COUNT(*) > 1
ORDER BY f.title;
