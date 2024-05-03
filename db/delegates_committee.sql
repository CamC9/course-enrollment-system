CREATE TABLE delegates_committee (
    PID VARCHAR(255) NOT NULL,
    faculty_name VARCHAR(255) NOT NULL,
    PRIMARY KEY (PID, faculty_name),
    FOREIGN KEY (PID) REFERENCES students(PID),
    FOREIGN KEY (faculty_name) REFERENCES faculty(faculty_name)
);

-- Valid teacherdb/teachings.sql 
INSERT INTO delegates_committee (PID, faculty_name)
    VALUES ('A99', 'John Doe');