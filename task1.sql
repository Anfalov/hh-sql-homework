CREATE TABLE specialization
(
  specialization_id   serial PRIMARY KEY,
  specialization_name text NOT NULL
);


CREATE TABLE area
(
  area_id   serial PRIMARY KEY,
  area_name text NOT NULL
);


CREATE TABLE employer
(
  employer_id   serial PRIMARY KEY,
  employer_name text    NOT NULL,
  area_id       integer NOT NULL REFERENCES area (area_id)
);


CREATE TABLE vacancy
(
  vacancy_id        serial PRIMARY KEY,
  vacancy_title     text      NOT NULL,
  employer_id       integer   NOT NULL REFERENCES employer (employer_id),
  description       text,
  compensation_from integer,
  compensation_to   integer,
  area_id           integer   NOT NULL REFERENCES area (area_id),
  specialization_id integer   NOT NULL REFERENCES specialization (specialization_id),
  publication_time  timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
);


CREATE TABLE job_seeker
(
  job_seeker_id   serial PRIMARY KEY,
  job_seeker_name text    NOT NULL,
  area_id         integer NOT NULL REFERENCES area (area_id)
);


CREATE TABLE resume
(
  resume_id         serial PRIMARY KEY,
  resume_title      text      NOT NULL,
  job_seeker_id     integer   NOT NULL REFERENCES job_seeker (job_seeker_id),
  compensation_from integer,
  compensation_to   integer,
  area_id           integer   NOT NULL REFERENCES area (area_id),
  specialization_id integer   NOT NULL REFERENCES specialization (specialization_id),
  publication_time  timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
);


CREATE TABLE response
(
  response_id   serial PRIMARY KEY,
  resume_id     integer   NOT NULL REFERENCES resume (resume_id),
  vacancy_id    integer   NOT NULL REFERENCES vacancy (vacancy_id),
  response_time timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
);