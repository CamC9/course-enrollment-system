CREATE TABLE advised_by (
    PID VARCHAR(255) NOT NULL,
    faculty_name VARCHAR(255) NOT NULL,
    PRIMARY KEY (PID, faculty_name),
    FOREIGN KEY (PID) REFERENCES students(PID),
    FOREIGN KEY (faculty_name) REFERENCES faculty(faculty_name)
);

-- Valid PID
INSERT INTO delegates_committee (PID, faculty_name)
    VALUES ('A99', 'John Doe');

-- Invalid PID
INSERT INTO delegates_committee (PID, faculty_name)
    VALUES ('NOT_A_PID', 'Test');

-- Invalid faculty_name
INSERT INTO delegates_committee (PID, faculty_name)
    VALUES ('A99', 'NOT_A_FACULTY_NAME');

-- Duplicate entry
INSERT INTO delegates_committee (PID, faculty_name)
    VALUES ('A99', 'John Doe');

-- Same faculty, different student
INSERT INTO delegates_committee (PID, faculty_name)
    VALUES ('A88', 'John Doe');