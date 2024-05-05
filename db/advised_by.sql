CREATE TABLE advised_by (
    PID VARCHAR(255) NOT NULL,
    faculty_name VARCHAR(255) NOT NULL,
    PRIMARY KEY (PID, faculty_name),
    FOREIGN KEY (PID) REFERENCES students(PID),
    FOREIGN KEY (faculty_name) REFERENCES faculty(name)
);

-- Valid PID
INSERT INTO advised_by (PID, faculty_name)
    VALUES ('A99', 'John Doe');

-- Same faculty, different student
INSERT INTO advised_by (PID, faculty_name)
    VALUES ('A88', 'John Doe');

INSERT INTO advised_by (PID, faculty_name)
    VALUES ('A1', 'Jane Doe');