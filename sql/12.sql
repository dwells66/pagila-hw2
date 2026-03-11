/*
 * List the title of all movies that have both the 'Behind the Scenes' and the 'Trailers' special_feature
 *
 * HINT:
 * Create a select statement that lists the titles of all tables with the 'Behind the Scenes' special_feature.
 * Create a select statement that lists the titles of all tables with the 'Trailers' special_feature.
 * Inner join the queries above.
 */

SELECT f.title
FROM (
    SELECT film_id
    FROM film
    WHERE 'Behind the Scenes' IN (
        SELECT unnest(special_features)
    )
) AS bs
INNER JOIN (
    SELECT film_id
    FROM film
    WHERE 'Trailers' IN (
        SELECT unnest(special_features)
    )
) AS tr
ON bs.film_id = tr.film_id
JOIN film AS f
ON bs.film_id = f.film_id
ORDER BY f.title;
