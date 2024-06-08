CREATE TABLE prerequisites (
    course_id int NOT NULL,
    prerequisite_id int NOT NULL,
    id SERIAL PRIMARY KEY,
    FOREIGN KEY (course_id) REFERENCES courses(course_id),
    FOREIGN KEY (prerequisite_id) REFERENCES courses(course_id)
);

INSERT INTO prerequisites (course_id, prerequisite_id)
    VALUES (1, 3);
INSERT INTO prerequisites (course_id, prerequisite_id)
    VALUES (4, 1);
INSERT INTO prerequisites (course_id, prerequisite_id)
    VALUES (5, 1);