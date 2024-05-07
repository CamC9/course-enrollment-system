CREATE TABLE enrollment (
    student_pid VARCHAR(255) NOT NULL,
    course_name VARCHAR(255) NOT NULL,
    section_id int NOT NULL,
    grade VARCHAR(255),
    quarter VARCHAR(255),
    year int,
    enrollment_id int PRIMARY KEY,
    FOREIGN KEY (course_name) REFERENCES courses(course_name),
    FOREIGN KEY (student_pid) REFERENCES students(PID),
    FOREIGN KEY (section_id) REFERENCES class_sections(section_id)
);

-- Valid entries, make sure section id 1 exists
INSERT INTO enrollment (student_pid, course_name, section_id, grade, enrollment_id) 
    VALUES ('A88', 'CSE_156', 2, 'A', 'SPRING', 2016, 1);
INSERT INTO enrollment (student_pid, course_name, section_id, grade, enrollment_id)
    VALUES ('A99', 'CSE_156', 2, 'B-', 'WINTER', 2016, 2);
INSERT INTO enrollment (student_pid, course_name, section_id, grade, enrollment_id)
    VALUES ('A99', 'CSE_132B', 1, 'A', 'FALL', 2013, 3);