CREATE TABLE classes (
    course_name VARCHAR(255) NOT NULL,
    class_title VARCHAR(255) NOT NULL,
    quarter VARCHAR(255) NOT NULL,
    year int NOT NULL,
    offering_id int PRIMARY KEY,
    FOREIGN KEY (course_name) REFERENCES courses(course_name)
);

INSERT INTO classes (course_name, class_title, quarter, year, offering_id) 
    VALUES ('CSE132A', 'DB System Principles', 'Spring', 2018, 1);
INSERT INTO classes (course_name, class_title, quarter, year, offering_id) 
    VALUES ('CSE291', 'Advanced Topics in CS', 'Fall', 2017, 2);
INSERT INTO classes (course_name, class_title, quarter, year, offering_id) 
    VALUES ('CSE101', 'Introduction to Programming', 'Winter', 2017, 3); 
INSERT INTO classes (course_name, class_title, quarter, year, offering_id) 
    VALUES ('CSE132B', 'Advanced Databases', 'Winter', 2018, 4); 
INSERT INTO classes (course_name, class_title, quarter, year, offering_id) 
    VALUES ('CSE232A', 'Machine Learning Algorithms', 'Spring', 2018, 5); 
INSERT INTO classes (course_name, class_title, quarter, year, offering_id) 
    VALUES ('MATH101', 'Calculus I', 'Spring', 2017, 6); 
INSERT INTO classes (course_name, class_title, quarter, year, offering_id) 
    VALUES ('PHYS101', 'Physics I', 'Fall', 2017, 7);
INSERT INTO classes (course_name, class_title, quarter, year, offering_id) 
    VALUES ('BIO101', 'Introduction to Biology', 'Spring', 2017, 8);
INSERT INTO classes (course_name, class_title, quarter, year, offering_id) 
    VALUES ('CHEM101', 'General Chemistry', 'Fall', 2017, 9);
INSERT INTO classes (course_name, class_title, quarter, year, offering_id) 
    VALUES ('STAT101', 'Introduction to Statistics', 'Winter', 2018, 10);
INSERT INTO classes (course_name, class_title, quarter, year, offering_id) 
    VALUES ('CSE132A', 'DB System Principles 2', 'Fall', 2017, 11);
INSERT INTO classes (course_name, class_title, quarter, year, offering_id) 
    VALUES ('CSE291B', 'Advanced Topics in Machine Learning 2', 'Winter', 2019, 12);
INSERT INTO classes (course_name, class_title, quarter, year, offering_id) 
    VALUES ('CSE132C', 'Database System Applications', 'Spring', 2018, 13);