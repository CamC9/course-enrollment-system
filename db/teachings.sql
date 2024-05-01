CREATE TABLE teachings (
    faculty_name VARCHAR(255) NOT NULL,
    course_name int NOT NULL,
    quarter VARCHAR(255) NOT NULL,
    year int NOT NULL,
    enrollmentID int PRIMARY KEY,
    FOREIGN KEY (faculty_name) REFERENCES faculty(name),
    FOREIGN KEY (course_name) REFERENCES courses(course_name)
);

-- Valid teacher 
INSERT INTO teachings (faculty_name, course_name, quarter, year, enrollmentID) 
    VALUES ('John Doe', 'CSE_132B', 'SPRING', 2018, 1);
INSERT INTO teachings (faculty_name, course_name, quarter, year, enrollmentID) 
    VALUES ('NOT_A_FACULTY', 'CSE_132B', 'SPRING', 2018, 2);
-- Invalid course
INSERT INTO teachings (faculty_name, course_name, quarter, year, enrollmentID) 
    VALUES ('Jane Doe', 'NOT_A_COURSE', 'SPRING', 2018, 3);
-- Duplicate EnrollmentID
INSERT INTO teachings (faculty_name, course_name, quarter, year, enrollmentID) 
    VALUES ('Test Professor', 'CSE_132B', 'SPRING', 2018, 1);
-- Future quarter
INSERT INTO teachings (faculty_name, course_name, quarter, year, enrollmentID) 
    VALUES ('Test Professor', 'CSE_132B', 'WINTER', 2019, 4);
-- Past quarter
INSERT INTO teachings (faculty_name, course_name, quarter, year, enrollmentID) 
    VALUES ('Test Professor', 'CSE_105', 'FALL', 2017, 5);