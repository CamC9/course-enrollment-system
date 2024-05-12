CREATE TABLE previously_known_as (
    course_name VARCHAR(255) NOT NULL,
    previous_course_name VARCHAR(255) NOT NULL,
    id SERIAL PRIMARY KEY,
    FOREIGN KEY (course_name) REFERENCES courses(course_name),
    FOREIGN KEY (previous_course_name) REFERENCES courses(course_name)
);

-- Valid entries, make sure section id 1 exists
INSERT INTO previously_known_as (course_name, previous_course_name)
    VALUES ('CSE_132B', 'CSE_132');

-- Create dependency tree of courses
INSERT INTO previously_known_as (course_name, previous_course_name)
    VALUES ('CSE_132', 'CSE_197');