CREATE TABLE past_enrollment (
    student_pid VARCHAR(255) NOT NULL,
    course_name VARCHAR(255) NOT NULL,
    section_id int NOT NULL,
    grade VARCHAR(255),
    quarter VARCHAR(255),
    year int,
    enrollment_id SERIAL PRIMARY KEY,
    FOREIGN KEY (course_name) REFERENCES courses(course_name),
    FOREIGN KEY (student_pid) REFERENCES students(PID),
    FOREIGN KEY (section_id) REFERENCES class_sections(section_id)
);

-- Valid entries, make sure section id 1 exists
INSERT INTO past_enrollment (student_pid, course_name, section_id, grade, quarter, year) 
    VALUES ('A88', 'CSE_156', 10, 'A', 'SPRING', 2016);
INSERT INTO past_enrollment (student_pid, course_name, section_id, grade, quarter, year)
    VALUES ('A99', 'CSE_156', 11, 'B-', 'WINTER', 2016);
INSERT INTO past_enrollment (student_pid, course_name, section_id, grade, quarter, year)
    VALUES ('A99', 'CSE_132B', 12, 'A', 'FALL', 2013);