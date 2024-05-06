CREATE TABLE enrollment (
    student_pid VARCHAR(255) NOT NULL,
    course_name VARCHAR(255) NOT NULL,
    section_id int NOT NULL,
    grade VARCHAR(255),
    enrollment_id int PRIMARY KEY,
    FOREIGN KEY (student_pid) REFERENCES students(PID),
    FOREIGN KEY (section_id) REFERENCES class_sections(section_id)
);

-- Valid entries, make sure section id 1 exists
INSERT INTO enrollment (student_pid, section_id, grade, enrollment_id) 
    VALUES ('A88', 1, 'A', 1);
INSERT INTO enrollment (student_pid, section_id, grade, enrollment_id)
    VALUES ('A99', 1, 'B-', 2);

-- Find case where student tries to enroll in a section that does not exist