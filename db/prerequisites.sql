CREATE TABLE prerequisites (
    course_name VARCHAR(255) NOT NULL,
    prerequisite_name VARCHAR(255) NOT NULL,
    prerequisite_id int PRIMARY KEY,
    FOREIGN KEY (course_name) REFERENCES courses(course_name),
    FOREIGN KEY (prerequisite_name) REFERENCES courses(course_name)
);

-- Valid Course 
INSERT INTO prerequisites (course_name, prerequisite_name, prerequisite_id)
    VALUES ('CSE_132B', 'CSE_105', 1);
INSERT INTO prerequisites (course_name, prerequisite_name, prerequisite_id)
    VALUES ('CSE_105', 'CSE_105', 2);
INSERT INTO prerequisites (course_name, prerequisite_name, prerequisite_id)
    VALUES ('CSE_132B', 'CSE_132A', 3);
