SELECT
  area_id AS area_id,
  avg(compensation_from) AS average_compensation_from,
  avg(compensation_to) AS average_compensation_to,
  avg((compensation_to + compensation_from) / 2) AS average_compensation
FROM vacancy
GROUP BY area_id
ORDER BY area_id;
