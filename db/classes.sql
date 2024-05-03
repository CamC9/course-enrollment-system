CREATE TABLE classes (
    course_name VARCHAR(255) NOT NULL,
    class_title VARCHAR(255) NOT NULL,
    year int NOT NULL,
    quarter VARCHAR(255) NOT NULL,
    offering_id int PRIMARY KEY,
    FOREIGN KEY (course_name) REFERENCES courses(course_name)
);

-- Valid entriess
INSERT INTO classes (course_name, class_title, year, quarter, offering_id)
    VALUES ('CSE_132B', 'Database Systems Applications', 2018, 'SPRING', 1);

-- Invalid course
INSERT INTO classes (course_name, class_title, year, quarter, offering_id)
    VALUES ('NOT_A_COURSE', 'Test', 2018, 'SPRING', 2);

-- Duplicate offering_id
INSERT INTO classes (course_name, class_title, year, quarter, offering_id)
    VALUES ('CSE_132B', 'Database Systems Applications', 2018, 'SPRING', 1);

-- Past quarter
INSERT INTO classes (course_name, class_title, year, quarter, offering_id)
    VALUES ('CSE_105', 'Intro to Algorithms', 2017, 'FALL', 3);

-- Future quarter
INSERT INTO classes (course_name, class_title, year, quarter, offering_id)
    VALUES ('CSE_105', 'Intro to Algorithms', 2019, 'WINTER', 4);