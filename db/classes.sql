CREATE TABLE classes (
    class_id int PRIMARY KEY,
    course_id int NOT NULL,
    class_title VARCHAR(255) NOT NULL,
    quarter VARCHAR(255) NOT NULL,
    year int NOT NULL,
    FOREIGN KEY (course_id) REFERENCES courses(course_id)
);

INSERT INTO classes (class_id, course_id, class_title, quarter, year) 
    VALUES (1, 1, 'DB System Principles', 'Spring', 2018);
INSERT INTO classes (class_id, course_id, class_title, quarter, year) 
    VALUES (2, 2, 'Advanced Topics in CS', 'Fall', 2017);
INSERT INTO classes (class_id, course_id, class_title, quarter, year) 
    VALUES (3, 3, 'Introduction to Programming', 'Winter', 2017); 
INSERT INTO classes (class_id, course_id, class_title, quarter, year) 
    VALUES (4, 4, 'Advanced Databases', 'Winter', 2018); 
INSERT INTO classes (class_id, course_id, class_title, quarter, year) 
    VALUES (5, 5, 'Machine Learning Algorithms', 'Spring', 2018); 
INSERT INTO classes (class_id, course_id, class_title, quarter, year) 
    VALUES (6, 6, 'Calculus I', 'Spring', 2017); 
INSERT INTO classes (class_id, course_id, class_title, quarter, year) 
    VALUES (7, 7, 'Physics I', 'Fall', 2017);
INSERT INTO classes (class_id, course_id, class_title, quarter, year) 
    VALUES (8, 8, 'Introduction to Biology', 'Spring', 2017);
INSERT INTO classes (class_id, course_id, class_title, quarter, year) 
    VALUES (9, 9, 'General Chemistry', 'Fall', 2017);
INSERT INTO classes (class_id, course_id, class_title, quarter, year) 
    VALUES (10, 10, 'Introduction to Statistics', 'Winter', 2018);
INSERT INTO classes (class_id, course_id, class_title, quarter, year) 
    VALUES (11, 1, 'DB System Principles 2', 'Fall', 2017);
INSERT INTO classes (class_id, course_id, class_title, quarter, year) 
    VALUES (12, 12, 'Advanced Topics in Machine Learning 2', 'Winter', 2019);
INSERT INTO classes (class_id, course_id, class_title, quarter, year) 
    VALUES (13, 11, 'Database System Applications', 'Spring', 2018);