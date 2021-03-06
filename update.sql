CREATE TEMP TABLE temp_us
(LIKE covid19.covid19us INCLUDING ALL);

\COPY temp_us from '~/git/nytimes-covid19-data/us-counties.csv' delimiter ',' header csv;

INSERT INTO covid19.covid19us (date, county, state, fips, cases, deaths)
SELECT t2.* FROM temp_us t2
LEFT JOIN covid19.covid19us t1 ON
t1.date = t2.date
WHERE
t1.date is NULL
ON CONFLICT DO NOTHING
RETURNING *;
