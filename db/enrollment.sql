CREATE TABLE enrollment (
    student_pid VARCHAR(255) NOT NULL,
    course_name VARCHAR(255) NOT NULL,
    section_id int NOT NULL,
    waitlist_spot int NOT NULL DEFAULT 0,
    enrollment_id SERIAL PRIMARY KEY,
    FOREIGN KEY (course_name) REFERENCES courses(course_name),
    FOREIGN KEY (student_pid) REFERENCES students(PID),
    FOREIGN KEY (section_id) REFERENCES class_sections(section_id)
);

-- Valid entries, make sure section id 1 exists
INSERT INTO enrollment (student_pid, course_name, section_id) 
    VALUES ('A88', 'CSE_156', 2);
INSERT INTO enrollment (student_pid, course_name, section_id)
    VALUES ('A99', 'CSE_156', 10);
INSERT INTO enrollment (student_pid, course_name, section_id)
    VALUES ('A99', 'CSE_132B', 1);