-- Для запросов добавлены индексы.
-- 3. *idx_vacancies_area_id* (area_id) для ускорения группировки вакансий по регионам для расчёта средних значений.
-- 4. *idx_vacancies_published_at* (published_at) ускоряет фильтры и агрегаты по дате публикации вакансий
--    *idx_resumes_created_at* (created_at)  ускоряет подсчёт резюме по месяцам и временные фильтры
-- 5.  *idx_responses_vacancy_id* (vacancy_id) ускоряет JOIN между вакансиями и откликами
--     *idx_responses_vacancy_created* (vacancy_id, created_at) быстрый доступ к откликам не только по вакансии, но и по дате
--     *idx_vacancies_id_published* (vacancy_id, published_at) ускоряет доступ к дате публикации при соединении с откликами.

CREATE INDEX idx_vacancies_area_id
    ON vacancies (area_id);

CREATE INDEX idx_vacancies_published_at
    ON vacancies (published_at);

CREATE INDEX idx_resumes_created_at
    ON resumes (created_at);

CREATE INDEX idx_responses_vacancy_id
    ON responses (vacancy_id);

CREATE INDEX idx_responses_vacancy_created_at
    ON responses (vacancy_id, created_at);

CREATE INDEX idx_vacancies_published_at_id
    ON vacancies (vacancy_id, published_at);