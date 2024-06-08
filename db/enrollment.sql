CREATE TABLE enrollment (
    student_pid VARCHAR(255) NOT NULL,
    class_id int NOT NULL,
    section_id VARCHAR(255) NOT NULL,
    units int NOT NULL,
    waitlist_spot int NOT NULL DEFAULT 0,
    enrollment_id SERIAL PRIMARY KEY,
    FOREIGN KEY (student_pid) REFERENCES students(PID),
    FOREIGN KEY (section_id) REFERENCES class_sections(section_id),
    FOREIGN KEY (class_id) REFERENCES classes(class_id)
);

-- Valid entries, make sure section id 1 exists
INSERT INTO enrollment (student_pid, class_id, section_id, units) 
    VALUES ('1', 1, 'S1', 4);
INSERT INTO enrollment (student_pid, class_id, section_id, units) 
    VALUES ('2', 1, 'S1', 4);
INSERT INTO enrollment (student_pid, class_id, section_id, units) 
    VALUES ('2', 5, 'S5', 4);
INSERT INTO enrollment (student_pid, class_id, section_id, units) 
    VALUES ('3', 1, 'S1', 4);
INSERT INTO enrollment (student_pid, class_id, section_id, units) 
    VALUES ('4', 1, 'S1', 4);
INSERT INTO enrollment (student_pid, class_id, section_id, units) 
    VALUES ('5', 1, 'S1', 4);
INSERT INTO enrollment (student_pid, class_id, section_id, units) 
    VALUES ('6', 1, 'S1', 4);
INSERT INTO enrollment (student_pid, class_id, section_id, units) 
    VALUES ('7', 1, 'S1', 4);