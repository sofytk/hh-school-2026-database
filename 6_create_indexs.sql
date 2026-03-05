-- Для запросов добавлены индексы.
-- 3. idx_vacancies_area_id (area_id) для ускорения группировки вакансий по регионам для расчёта средних значений.
-- 4. idx_vacancies_created_at (created_at) ускоряет фильтры и агрегаты по дате публикации вакансий
--    idx_resumes_created_at (created_at)  ускоряет подсчёт резюме по месяцам и временные фильтры
-- 5. idx_responses_vacancy_created_at (vacancy_id, created_at) быстрый доступ к откликам по вакансии, но и по дате

CREATE INDEX idx_vacancies_area_id
    ON vacancies (area_id);

CREATE INDEX idx_vacancies_created_at
    ON vacancies (created_at);

CREATE INDEX idx_resumes_created_at
    ON resumes (created_at);

-- CREATE INDEX idx_responses_vacancy_id
--     ON responses (vacancy_id);

CREATE INDEX idx_responses_vacancy_created_at
    ON responses (vacancy_id, created_at);

-- CREATE INDEX idx_vacancies_published_at
--     ON vacancies (vacancy_id, published_at);

DROP INDEX IF EXISTS idx_responses_vacancy_id;
DROP INDEX IF EXISTS idx_vacancies_published_at;