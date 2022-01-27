SELECT
  v.vacancy_id AS vacancy_id,
  v.vacancy_title AS vacancy_title
FROM vacancy v
INNER JOIN response r ON v.vacancy_id = r.vacancy_id
AND r.response_time <= v.publication_time + 7 * INTERVAL '1 day'
GROUP BY v.vacancy_id
HAVING count(r.response_id) > 5;
