CREATE TABLE concentration_consists_of (
    degree_name VARCHAR(255) NOT NULL,
    concentration_name VARCHAR(255) NOT NULL,
    course_name VARCHAR(255) NOT NULL,
    id SERIAL PRIMARY KEY,
    FOREIGN KEY (course_name) REFERENCES courses(course_name)
);

INSERT INTO concentration_consists_of (degree_name, concentration_name, course_name)
    VALUES ('MSC IN CS', 'Artificial Intelligence', 'CSE_132B');

INSERT INTO concentration_consists_of (degree_name, concentration_name, course_name)
    VALUES ('MSC IN CS', 'Artificial Intelligence', 'CSE_156');

INSERT INTO concentration_consists_of (degree_name, concentration_name, course_name)
    VALUES ('MSC IN CS', 'Artificial Intelligence', 'CSE_110');

INSERT INTO concentration_consists_of (degree_name, concentration_name, course_name)
    VALUES ('MSC IN CS', 'Database', 'CSE_132B');

INSERT INTO concentration_consists_of (degree_name, concentration_name, course_name)
    VALUES ('MSC IN CS', 'Database', 'CSE_132A');