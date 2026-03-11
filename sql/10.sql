/*
 * Management is planning on purchasing new inventory.
 * Films with special features cost more to purchase than films without special features,
 * and so management wants to know if the addition of special features impacts revenue from movies.
 *
 * Write a query that for each special_feature, calculates the total profit of all movies rented with that special feature.
 *
 * HINT:
 * Start with the query you created in pagila-hw1 problem 16, but add the special_features column to the output.
 * Use this query as a subquery in a select statement similar to answer to the previous problem.
 */

SELECT
    sf.special_feature,
    sum(fp.total_profit) AS profit
FROM (
    SELECT
        f.film_id,
        SUM(p.amount) AS total_profit
    FROM payment AS p
    JOIN rental AS r
        ON p.rental_id = r.rental_id
    JOIN inventory AS i
        ON r.inventory_id = i.inventory_id
    JOIN film as f
        ON i.film_id = f.film_id
    GROUP BY f.film_id
) AS fp
JOIN (
    SELECT
        film_id,
        unnest(special_features) AS special_feature
    FROM film
) AS sf
    ON fp.film_id = sf.film_id
GROUP BY sf.special_feature
ORDER BY sf.special_feature;
