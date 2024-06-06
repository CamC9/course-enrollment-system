CREATE TABLE concentration_consists_of (
    degree_name VARCHAR(255) NOT NULL,
    concentration_name VARCHAR(255) NOT NULL,
    course_id int NOT NULL,
    min_units_concentration INT NOT NULL,
    id SERIAL PRIMARY KEY
);

INSERT INTO concentration_consists_of (degree_name, concentration_name, course_id, min_units_concentration)
    VALUES ('MS in Computer Science', 'Machine Learning', 2, 12);
INSERT INTO concentration_consists_of (degree_name, concentration_name, course_id, min_units_concentration)
    VALUES ('MS in Computer Science', 'Machine Learning', 5, 12);
INSERT INTO concentration_consists_of (degree_name, concentration_name, course_id, min_units_concentration)
    VALUES ('MS in Computer Science', 'Machine Learning', 12, 12);
