/*
 * Management wants to send coupons to customers who have previously rented one of the top-5 most profitable movies.
 * Your task is to list these customers.
 *
 * HINT:
 * In problem 16 of pagila-hw1, you ordered the films by most profitable.
 * Modify this query so that it returns only the film_id of the top 5 most profitable films.
 * This will be your subquery.
 * 
 * Next, join the film, inventory, rental, and customer tables.
 * Use a where clause to restrict results to the subquery.
 */

WITH profit AS (
    SELECT
        f.film_id,
        sum(p.amount) AS profit
    FROM payment AS p
    JOIN rental AS r
        ON p.rental_id = r.rental_id
    JOIN inventory AS i
        ON r.inventory_id = i.inventory_id
    JOIN film as f
        ON i.film_id = f.film_id
    GROUP BY
        f.film_id
    ORDER BY
        profit DESC
    LIMIT 5
)
SELECT
    DISTINCT(c.customer_id)
FROM customer AS c
JOIN rental AS r
    ON c.customer_id = r.customer_id
JOIN inventory as i
    ON r.inventory_id = i.inventory_id
JOIN film as f
    ON i.film_id = f.film_id
WHERE f.film_id IN (SELECT film_id FROM profit)
ORDER BY
    c.customer_id
