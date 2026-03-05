ROLLBACK;
BEGIN;

SET synchronous_commit = OFF;
SET work_mem = '256MB';
SET maintenance_work_mem = '512MB';


INSERT INTO employers (name, description, website, industry, employee_count, founded_year)
SELECT
    'Компания ' || gs,
    'Описание компании ' || gs,
    'https://company' || gs || '.ru',
    (ARRAY['IT','Финансы','Образование','Маркетинг','Медицина'])[1 + (random()*4)::int],
    (ARRAY['1–10','11–50','51–200','201–1000','1000+'])[1 + (random()*4)::int],
    1990 + (random()*30)::int
FROM generate_series(1, 500) gs;


INSERT INTO specializations (name, description)
SELECT
    spec,
    'Описание специализации ' || spec
FROM unnest(ARRAY[
    'Backend разработчик','Frontend разработчик','Android разработчик',
    'iOS разработчик','Data Scientist','ML Engineer','DevOps',
    'QA Engineer','Product Manager','Project Manager',
    'UI/UX Designer','System Analyst','Business Analyst',
    'HR','Recruiter','Маркетолог','SEO специалист',
    'Копирайтер','Контент-менеджер','SMM',
    'Sales manager','Account manager','Support engineer',
    'Game developer','Embedded developer','Security engineer',
    'Data Engineer','Python developer','Java developer','Kotlin developer'
    ]) spec;



INSERT INTO applicants
(first_name, last_name, email, phone, birth_date, city, experience_years, education_level)
SELECT
    'Имя' || gs,
    'Фамилия' || gs,
    'user' || gs || '@mail.ru',
    '+79' || (900000000 + gs),
    DATE '1985-01-01' + (random()*12000)::int,
    (ARRAY['Москва','СПб','Казань','Новосибирск','Екатеринбург'])[1 + (random()*4)::int],
    (random()*15)::int,
    (ARRAY['Среднее','Среднее профессиональное','Высшее'])[1 + (random()*2)::int]
FROM generate_series(1, 100000) gs;



INSERT INTO resumes
(title, desired_position, specialization_id,
 salary_min, description, skills, employment_type, work_schedule, created_at)
SELECT
    a.applicants_id,
    'Резюме ' || a.applicants_id,
    s.specializations_id,
    30000 + (random()*150000)::int,
    'Опыт работы и описание кандидата',
    ARRAY['Java','SQL','Spring','Git','Docker'],
    (ARRAY['полная','частичная','проектная','стажировка'])[1 + (random()*3)::int],
    (ARRAY['полный день','сменный график','гибкий график','удаленная работа'])[1 + (random()*3)::int],
    TIMESTAMP '2025-01-01' + (random() * INTERVAL '1 year')
FROM applicants a
         JOIN specializations s ON random() < 0.1;



INSERT INTO vacancies
(
    employer_id,
    position_name,
    compensation_from,
    compensation_to,
    area_id,
    education,
    experience_required,
    employment_type,
    employment_contract_type,
    employment_format_type,
    description,
    views_count,
    created_at
)
SELECT
    e.employer_id,
    s.name,
    50000 + (random()*100000)::int,
    150000 + (random()*200000)::int,
    (random() * 85 + 1)::int,
    (ARRAY['Не требуется или не указано','Среднее профессиональное','Высшее'])[1 + (random()*2)::int],
    (ARRAY['Не имеет значения', 'Нет опыта', 'От 1 года до 3 лет','От 3 до 6 лет', 'Более 6 лет'])[1 + (random()*2)::int],
    (ARRAY['Полная занятость','Частичная занятость','Подработка','Вахта'])[1 + (random()*3)::int],
    (ARRAY[
        'Трудовой договор',
        'Оформление по ГПХ или по совместительству',
        'Самозанятость',
        'ИП',
        'Стажировка'
        ])[1 + (random()*4)::int],
    (ARRAY['На месте работодателя','Удалённо','Гибрид','Разъездной'])[1 + (random()*3)::int],
    'Описание вакансии',
    (random()*1000)::int,
    TIMESTAMP '2025-01-01' + (random() * INTERVAL '1 year')
FROM employers e
         JOIN specializations s ON random() < 0.05
LIMIT 10000;



INSERT INTO responses
(vacancy_id, resume_id, cover_letter, response_status, viewed_by_company, created_at)
SELECT DISTINCT
    v.vacancy_id,
    r.resume_id,
    'Сопроводительное письмо',
    (ARRAY['отправлен','просмотрен','приглашение','отказ'])[1 + (random()*3)::int],
    random() < 0.5,
    v.created_at
        + ( (1 + floor(random() * 30)) * INTERVAL '1 day' )
FROM vacancies v
         JOIN resumes r ON random() < 0.15
LIMIT 300000;

COMMIT;






