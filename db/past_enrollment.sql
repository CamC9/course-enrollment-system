CREATE TABLE past_enrollment (
    student_pid VARCHAR(255) NOT NULL,
    class_id int NOT NULL,
    section_id VARCHAR(255) NOT NULL,
    units int NOT NULL,
    grade VARCHAR(255),
    enrollment_id SERIAL PRIMARY KEY,
    FOREIGN KEY (class_id) REFERENCES classes(class_id),
    FOREIGN KEY (student_pid) REFERENCES students(PID),
    FOREIGN KEY (section_id) REFERENCES class_sections(section_id)
);

-- Valid entries, make sure section id 1 exists
INSERT INTO past_enrollment (student_pid, class_id, section_id, units, grade) 
    VALUES ('1', 2, 'S2', 4, 'A');
INSERT INTO past_enrollment (student_pid, class_id, section_id, units, grade) 
    VALUES ('1', 3, 'S3', 4, 'B+');
INSERT INTO past_enrollment (student_pid, class_id, section_id, units, grade) 
    VALUES ('2', 3, 'S3', 4, 'B');
INSERT INTO past_enrollment (student_pid, class_id, section_id, units, grade) 
    VALUES ('3', 4, 'S4', 4, 'A-');
INSERT INTO past_enrollment (student_pid, class_id, section_id, units, grade) 
    VALUES ('4', 6, 'S6', 4, 'B+');
INSERT INTO past_enrollment (student_pid, class_id, section_id, units, grade) 
    VALUES ('5', 7, 'S7', 4, 'A');
INSERT INTO past_enrollment (student_pid, class_id, section_id, units, grade) 
    VALUES ('6', 8, 'S8', 4, 'A');
INSERT INTO past_enrollment (student_pid, class_id, section_id, units, grade) 
    VALUES ('7', 9, 'S9', 4, 'B+');
INSERT INTO past_enrollment (student_pid, class_id, section_id, units, grade) 
    VALUES ('1', 10, 'S10', 4, 'A-');
INSERT INTO past_enrollment (student_pid, class_id, section_id, units, grade) 
    VALUES ('1', 11, 'S11', 4, 'A');
INSERT INTO past_enrollment (student_pid, class_id, section_id, units, grade) 
    VALUES ('2', 2, 'S2', 4, 'A-');
INSERT INTO past_enrollment (student_pid, class_id, section_id, units, grade) 
    VALUES ('7', 3, 'S3', 4, 'A');
INSERT INTO past_enrollment (student_pid, class_id, section_id, units, grade) 
    VALUES ('6', 3, 'S3', 4, 'A');
