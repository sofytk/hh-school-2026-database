SELECT
    TO_CHAR(date_trunc('month', created_at), 'YYYY-MM') AS month,
    COUNT(*) AS vacancies_count
FROM vacancies
GROUP BY month
ORDER BY vacancies_count DESC
LIMIT 1;

SELECT
    TO_CHAR(date_trunc('month', created_at), 'YYYY-MM') AS month,
    COUNT(*) AS resumes_count
FROM resumes
GROUP BY month
ORDER BY resumes_count DESC
LIMIT 1;
