SELECT
    area_id,
    ROUND(AVG(compensation_from), 2),
    ROUND(AVG(compensation_to), 2),
    ROUND(AVG((compensation_from + compensation_to) / 2.0), 2)
FROM vacancies
GROUP BY area_id
ORDER BY area_id;