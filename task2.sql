INSERT INTO area (area_name)
VALUES ('Москва'),
       ('Санкт-Петербург'),
       ('Новосибирск'),
       ('Екатеринбург'),
       ('Казань'),
       ('Нижний Новгород'),
       ('Челябинск'),
       ('Самара'),
       ('Омск'),
       ('Ростов-на-Дону'),
       ('Уфа'),
       ('Красноярск'),
       ('Воронеж'),
       ('Пермь'),
       ('Волгоград');


INSERT INTO specialization (specialization_name)
VALUES ('Автомобильный бизнес'),
       ('Административный персонал'),
       ('Безопасность'),
       ('Высший менеджмент'),
       ('Добыча сырья'),
       ('Домашний, обслуживающий персонал'),
       ('Закупки'),
       ('Информационные технологии'),
       ('Искусство, развлечения, масс-медиа'),
       ('Маркетинг, реклама, PR'),
       ('Медицина, фармацевтика'),
       ('Наука, образование'),
       ('Продажи, обслуживание клиентов'),
       ('Производство, сервисное обслуживание'),
       ('Рабочий персонал'),
       ('Розничная торговля'),
       ('Сельское хозяйство'),
       ('Спортивные клубы, фитнес, салоны красоты'),
       ('Стратегия, инвестиции, консалтинг'),
       ('Страхование'),
       ('Строительство, недвижимость'),
       ('Транспорт, логистика, перевозки'),
       ('Туризм, гостиницы, рестораны'),
       ('Управление персоналом, тренинги'),
       ('Финансы, бухгалтерия'),
       ('Юристы'),
       ('Другое');


-- Генерирую 1000 работодателей
WITH test_data(id, employer_name, area_id) AS (
  SELECT
    GENERATE_SERIES(1, 1000) AS id,
    MD5(RANDOM()::TEXT)      AS employer_name,
    FLOOR(RANDOM() * 15) + 1 AS area_id
)
INSERT
INTO employer(employer_name,
              area_id)
SELECT
  employer_name,
  area_id
FROM test_data;


-- Генерирую 10000 вакансий
WITH test_data AS (
  SELECT
    GENERATE_SERIES(1, 10000)    AS id,
    MD5(RANDOM()::TEXT)          AS vacancy_title,
    FLOOR(RANDOM() * 1000) + 1   AS employer_id,
    MD5(RANDOM()::TEXT)          AS description,
    FLOOR(RANDOM() * 100000) + 1 AS compensation,
    FLOOR(RANDOM() * 15) + 1     AS area_id,
    FLOOR(RANDOM() * 27) + 1     AS specialization_id
)
INSERT
INTO vacancy(vacancy_title,
             employer_id,
             description,
             compensation_from,
             compensation_to,
             area_id,
             specialization_id,
             publication_time)
SELECT
  vacancy_title,
  employer_id,
  description,
  compensation,
  compensation + (RANDOM() * (10001))::INT,
  area_id,
  specialization_id,
  CURRENT_TIMESTAMP - RANDOM() * 90 * INTERVAL '1 day'
FROM test_data;


-- Генерирую 50 000 соискателей
WITH test_data(id, job_seeker_name, area_id) AS (
  SELECT
    GENERATE_SERIES(1, 50000) AS id,
    MD5(RANDOM()::TEXT)       AS job_seeker_name,
    FLOOR(RANDOM() * 15) + 1  AS area_id
)
INSERT
INTO job_seeker(job_seeker_name,
                area_id)
SELECT
  job_seeker_name,
  area_id
FROM test_data;


-- Генерирую 100 000 резюме
WITH test_data AS (
  SELECT
    GENERATE_SERIES(1, 100000)   AS id,
    MD5(RANDOM()::TEXT)          AS resume_title,
    FLOOR(RANDOM() * 50000) + 1  AS job_seeker_id,
    FLOOR(RANDOM() * 100000) + 1 AS compensation,
    FLOOR(RANDOM() * 15) + 1     AS area_id,
    FLOOR(RANDOM() * 27) + 1     AS specialization_id
)
INSERT
INTO resume(resume_title,
            job_seeker_id,
            compensation_from,
            compensation_to,
            area_id,
            specialization_id,
            publication_time)
SELECT
  resume_title,
  job_seeker_id,
  compensation,
  compensation + (RANDOM() * (10001))::INT,
  area_id,
  specialization_id,
  CURRENT_TIMESTAMP - RANDOM() * 90 * INTERVAL '1 day'
FROM test_data;

-- Создаю 100 000 откликов
WITH test_data AS (
  SELECT
    GENERATE_SERIES(1, 100000) AS id,
    FLOOR(random() * 100000) + 1 AS resume_id,
    FLOOR(random() * 10000) + 1 AS vacancy_id
)
INSERT INTO response(resume_id, vacancy_id, response_time)
SELECT
  td.resume_id,
  td.vacancy_id,
  CASE WHEN r.publication_time > v.publication_time
    THEN r.publication_time + FLOOR(RANDOM() * 20) * INTERVAL '1 day'
    ELSE v.publication_time + FLOOR(RANDOM() * 20) * INTERVAL '1 day'
  END
FROM test_data AS td
INNER JOIN vacancy AS v ON td.vacancy_id = v.vacancy_id
INNER JOIN resume AS r ON td.resume_id = r.resume_id;