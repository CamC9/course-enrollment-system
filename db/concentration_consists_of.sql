CREATE TABLE concentration_consists_of (
    degree_name VARCHAR(255) NOT NULL,
    concentration_name VARCHAR(255) NOT NULL,
    course_id int NOT NULL,
    min_units_concentration INT NOT NULL,
    min_gpa DECIMAL(3, 2) DEFAULT 0.00,
    id SERIAL PRIMARY KEY
);

INSERT INTO concentration_consists_of (degree_name, concentration_name, course_id, min_units_concentration, min_gpa)
    VALUES ('MS in Computer Science', 'Machine Learning', 2, 12, 3.00);
INSERT INTO concentration_consists_of (degree_name, concentration_name, course_id, min_units_concentration, min_gpa)
    VALUES ('MS in Computer Science', 'Machine Learning', 5, 12, 3.00);
INSERT INTO concentration_consists_of (degree_name, concentration_name, course_id, min_units_concentration, min_gpa)
    VALUES ('MS in Computer Science', 'Machine Learning', 12, 12, 3.00);
