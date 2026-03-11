/*
 * This problem is the same as 07.sql,
 * but instead of using the NOT IN operator, you are to use a LEFT JOIN.
 */


SELECT
    f.title
FROM film AS f
LEFT JOIN (
    SELECT DISTINCT i.film_id
    FROM inventory AS i
    JOIN rental AS r
        ON i.inventory_id = r.inventory_id
    JOIN customer AS c
        ON r.customer_id = c.customer_id
    JOIN address AS a
        ON c.address_id = a.address_id
    JOIN city AS cy
        ON a.city_id = cy.city_id
    JOIN country AS co
        ON cy.country_id = co.country_id
    WHERE co.country = 'United States'
) countries
ON f.film_id = countries.film_id
WHERE countries.film_id IS NULL AND f.film_id IN (SELECT film_id FROM inventory)
ORDER BY f.title;
