/*
 * List the name of all actors who have appeared in a movie that has the 'Behind the Scenes' special_feature
 */

SELECT DISTINCT
    CONCAT(a.first_name, ' ', a.last_name) AS "Actor Name"
FROM actor AS a
JOIN film_actor AS fa
    ON a.actor_id = fa.actor_id
JOIN (
    SELECT
        film_id,
        unnest(special_features) AS special_feature
    FROM film
) AS sf
    ON fa.film_id = sf.film_id
WHERE sf.special_feature = 'Behind the Scenes'
ORDER BY "Actor Name";
