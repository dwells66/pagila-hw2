/*
 * Compute the total revenue for each film.
 * The output should include another new column "revenue percent" that shows the percent of total revenue that comes from the current film and all previous films.
 * That is, the "revenue percent" column is 100*"total revenue"/sum(revenue)
 *
 * HINT:
 * The `to_char` function can be used to achieve the correct formatting of your percentage.
 * See: <https://www.postgresql.org/docs/current/functions-formatting.html#FUNCTIONS-FORMATTING-EXAMPLES-TABLE>
 */


SELECT
    film_revenue_rank.rank,
    film_revenue_rank.title,
    film_revenue_rank.revenue,
    SUM(film_revenue_rank.revenue) OVER (ORDER BY film_revenue_rank.rank) AS "total revenue",
    TO_CHAR(
        100 * SUM(film_revenue_rank.revenue) OVER (ORDER BY film_revenue_rank.rank)
            / SUM(film_revenue_rank.revenue) OVER (), 'FM900.00'
    ) AS "percent revenue"
FROM (
SELECT
    RANK() OVER (ORDER BY COALESCE(SUM(p.amount), 0.00) DESC) AS rank,
    f.title,
    COALESCE(SUM(p.amount), 0.00) AS revenue
FROM film AS f
LEFT JOIN inventory AS i
    ON f.film_id = i.film_id
LEFT JOIN rental AS r
    ON i.inventory_id = r.inventory_id
LEFT JOIN payment AS p
    ON r.rental_id = p.rental_id
GROUP BY f.title
ORDER BY revenue DESC, f.title
) AS film_revenue_rank

ORDER BY film_revenue_rank.rank, film_revenue_rank.title;
