CREATE TABLE prerequisites (
    course_name VARCHAR(255) NOT NULL,
    prerequisite_name VARCHAR(255) NOT NULL,
    prerequisite_id SERIAL PRIMARY KEY,
    FOREIGN KEY (course_name) REFERENCES courses(course_name),
    FOREIGN KEY (prerequisite_name) REFERENCES courses(course_name)
);

INSERT INTO prerequisites (course_name, prerequisite_name)
    VALUES ('CSE132A', 'CSE101');
INSERT INTO prerequisites (course_name, prerequisite_name)
    VALUES ('CSE132B', 'CSE132A');
INSERT INTO prerequisites (course_name, prerequisite_name)
    VALUES ('CSE232A', 'CSE132A');