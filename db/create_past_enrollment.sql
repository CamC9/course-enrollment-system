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
