CREATE DATABASE hh_database;

CREATE TABLE employers
(
    employer_id    integer GENERATED ALWAYS AS IDENTITY primary key,
    name           VARCHAR(255) NOT NULL,
    description    TEXT,
    website        VARCHAR(255),
    logo_url       TEXT,
    industry       VARCHAR(255),
    employee_count VARCHAR(100),
    founded_year   INTEGER,
    created_at     TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at     TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE applicants
(
    applicants_id    INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    first_name       VARCHAR(100)        NOT NULL,
    last_name        VARCHAR(100)        NOT NULL,
    middle_name      VARCHAR(100),
    email            VARCHAR(255) UNIQUE NOT NULL,
    phone            VARCHAR(20),
    birth_date       DATE,
    city             VARCHAR(255),
    experience_years INTEGER   DEFAULT 0,
    education_level  VARCHAR(100),
    created_at       TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at       TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE vacancies
(
    vacancy_id               INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    employer_id              INTEGER NOT NULL REFERENCES employers (employer_id),
    position_name            TEXT    NOT NULL,
    compensation_from        INTEGER,
    compensation_to          INTEGER,
    area_id                   INTEGER,
    salary_currency          VARCHAR(50) DEFAULT 'Рубли'
        CHECK (salary_currency IN ('Рубли', 'Евро', 'Доллары')),
    payment_frequency        VARCHAR(50) DEFAULT 'два раза в месяц'
        CHECK (payment_frequency IN ('два раза в месяц', 'ежедневно', 'раз в неделю', 'раз в месяц', 'за проект')),
    education                VARCHAR(50)
        CHECK (education IN ('Не требуется или не указано', 'Среднее профессиональное', 'Высшее')),
    experience_required      VARCHAR(50) CHECK ( experience_required IN
                                                 ('Не требуется', 'От 1 года до 3 лет', 'От 3 до 6 лет',
                                                  'От 3 до 6 лет')),
    employment_type          VARCHAR(50) CHECK (employment_type IN (
                                                                    'Полная занятость',
                                                                    'Частичная занятость',
                                                                    'Подработка',
                                                                    'Вахта'
        )),
    employment_contract_type VARCHAR(100)
        CHECK (employment_contract_type IN (
                                            'Трудовой договор',
                                            'Оформление по ГПХ или по совместительству',
                                            'Самозанятость',
                                            'ИП',
                                            'Стажировка'
            )),
    employment_format_type   VARCHAR(50) CHECK (employment_format_type IN (
                                                                           'На месте работодателя',
                                                                           'Удалённо',
                                                                           'Гибрид',
                                                                           'Разъездной'
        )),
    description              TEXT,
    is_active                BOOLEAN     DEFAULT true,
    views_count              INTEGER     DEFAULT 0,
    responses_count          INTEGER     DEFAULT 0,
    published_at             TIMESTAMP   DEFAULT CURRENT_TIMESTAMP,
    expires_at               TIMESTAMP   DEFAULT (CURRENT_TIMESTAMP + INTERVAL '30 days'),
    created_at               TIMESTAMP   DEFAULT CURRENT_TIMESTAMP,
    updated_at               TIMESTAMP   DEFAULT CURRENT_TIMESTAMP
);


CREATE TABLE specializations
(
    specializations_id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    name               VARCHAR(255) NOT NULL,
    description        TEXT
);


CREATE TABLE resumes
(
    resume_id         INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    applicant_id      INTEGER      NOT NULL REFERENCES applicants (applicants_id) ON DELETE CASCADE,
    title             VARCHAR(255) NOT NULL,
    desired_position  VARCHAR(255) NOT NULL,
    specialization_id INTEGER      REFERENCES specializations (specializations_id) ON DELETE SET NULL,
    salary_min        INTEGER,
    salary_currency   VARCHAR(3) DEFAULT 'RUB',
    description       TEXT,
    skills            TEXT[],
    employment_type   VARCHAR(50) CHECK (employment_type IN ('полная', 'частичная', 'проектная', 'стажировка')),
    work_schedule     VARCHAR(50) CHECK (work_schedule IN
                                         ('полный день', 'сменный график', 'гибкий график', 'удаленная работа')),
    is_active         BOOLEAN    DEFAULT true,
    views_count       INTEGER    DEFAULT 0,
    created_at        TIMESTAMP  DEFAULT CURRENT_TIMESTAMP,
    updated_at        TIMESTAMP  DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE responses
(
    id                INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    vacancy_id        INTEGER NOT NULL REFERENCES vacancies (vacancy_id) ON DELETE CASCADE,
    resume_id         INTEGER NOT NULL REFERENCES resumes (resume_id) ON DELETE CASCADE,
    applicant_id      INTEGER NOT NULL REFERENCES applicants (applicants_id) ON DELETE CASCADE,
    cover_letter      TEXT,
    response_status   VARCHAR(50) DEFAULT 'отправлен'
        CHECK (response_status IN ('отправлен', 'просмотрен', 'приглашение', 'отказ', 'принят')),
    viewed_by_company BOOLEAN     DEFAULT false,
    viewed_at         TIMESTAMP,
    company_comment   TEXT,
    published_at      TIMESTAMP   DEFAULT CURRENT_TIMESTAMP,
    created_at        TIMESTAMP   DEFAULT CURRENT_TIMESTAMP,
    updated_at        TIMESTAMP   DEFAULT CURRENT_TIMESTAMP,
    UNIQUE (vacancy_id, resume_id)
);
