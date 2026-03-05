SELECT
    v.vacancy_id,
    v.position_name
FROM vacancies v
         JOIN responses r
              ON r.vacancy_id = v.vacancy_id
WHERE r.created_at
          BETWEEN v.created_at
          AND v.created_at + INTERVAL '7 days'
GROUP BY v.vacancy_id, v.position_name
HAVING COUNT(*) > 5;




