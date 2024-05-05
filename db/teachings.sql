CREATE TABLE teachings (
    faculty_name VARCHAR(255) NOT NULL,
    course_name VARCHAR(255) NOT NULL,
    quarter VARCHAR(255) NOT NULL,
    year int NOT NULL,
    teaching_id int PRIMARY KEY,
    FOREIGN KEY (faculty_name) REFERENCES faculty(name),
    FOREIGN KEY (course_name) REFERENCES courses(course_name)
);

-- Valid teacher 
INSERT INTO teachings (faculty_name, course_name, quarter, year, teaching_id) 
    VALUES ('John Doe', 'CSE_132B', 'SPRING', 2018, 1);

-- Future quarter
INSERT INTO teachings (faculty_name, course_name, quarter, year, teaching_id) 
    VALUES ('Jackson Doe', 'CSE_132B', 'WINTER', 2019, 4);

-- Past quarter
INSERT INTO teachings (faculty_name, course_name, quarter, year, teaching_id) 
    VALUES ('Jane Doe', 'CSE_105', 'FALL', 2017, 5);