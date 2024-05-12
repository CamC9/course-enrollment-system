CREATE TABLE prerequisites (
    course_name VARCHAR(255) NOT NULL,
    prerequisite_name VARCHAR(255) NOT NULL,
    prerequisite_id SERIAL PRIMARY KEY,
    FOREIGN KEY (course_name) REFERENCES courses(course_name),
    FOREIGN KEY (prerequisite_name) REFERENCES courses(course_name)
);

-- Valid Course 
INSERT INTO prerequisites (course_name, prerequisite_name)
    VALUES ('CSE_132B', 'CSE_105');
INSERT INTO prerequisites (course_name, prerequisite_name)
    VALUES ('CSE_105', 'CSE_105');
INSERT INTO prerequisites (course_name, prerequisite_name)
    VALUES ('CSE_132B', 'CSE_132A');
