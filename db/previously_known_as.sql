CREATE TABLE previously_known_as (
    course_name VARCHAR(255) NOT NULL,
    previous_course_name VARCHAR(255) NOT NULL,
    id SERIAL PRIMARY KEY
);

INSERT INTO previously_known_as (course_name, previous_course_name)
    VALUES ('CSE_132B', 'CSE_132');
INSERT INTO previously_known_as (course_name, previous_course_name)
    VALUES ('CSE_132', 'CSE_197');