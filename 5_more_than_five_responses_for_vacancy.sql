SELECT
    v.vacancy_id,
    v.position_name
FROM vacancies v
         JOIN responses r
              ON r.vacancy_id = v.vacancy_id
WHERE r.published_at
          BETWEEN v.published_at
          AND v.published_at + INTERVAL '7 days'
GROUP BY v.vacancy_id, v.position_name
HAVING COUNT(*) > 5;


