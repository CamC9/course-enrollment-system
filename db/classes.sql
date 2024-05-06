CREATE TABLE classes (
    course_name VARCHAR(255) NOT NULL,
    class_title VARCHAR(255) NOT NULL,
    quarter VARCHAR(255) NOT NULL,
    year int NOT NULL,
    offering_id int PRIMARY KEY,
    FOREIGN KEY (course_name) REFERENCES courses(course_name)
);

-- Valid entriess
INSERT INTO classes (course_name, class_title, quarter, year, offering_id)
    VALUES ('CSE_132B', 'Database Systems Applications', 'SPRING', 2018, 1);

-- Past quarter
INSERT INTO classes (course_name, class_title, quarter, year, offering_id)
    VALUES ('CSE_105', 'Intro to Algorithms', 'FALL', 2017, 3);

-- Future quarter
INSERT INTO classes (course_name, class_title, quarter, year, offering_id)
    VALUES ('CSE_105', 'Intro to Algorithms', 'WINTER', 2019, 4);

-- Valid entry
INSERT INTO classes (course_name, class_title, quarter, year, offering_id)
    VALUES ('CSE_156', 'Statistical Natural Language Processing', 'WINTER', 2018, 5); 

-- Valid entry
INSERT INTO classes (course_name, class_title, quarter, year, offering_id)
    VALUES ('COGS_112', 'Humor', 'SPRING', 2018, 2);