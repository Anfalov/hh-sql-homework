SELECT
(
  SELECT
    date_part('month', publication_time) AS month
  FROM vacancy
  GROUP BY date_part('month', publication_time)
  ORDER BY count(*) DESC
  LIMIT 1
) AS month_with_max_vacancies_count,
(
  SELECT
    DATE_PART('month', publication_time) AS month
  FROM resume
  GROUP BY DATE_PART('month', publication_time)
  ORDER BY count(*) DESC
  LIMIT 1
) AS month_with_max_resumes_count;
