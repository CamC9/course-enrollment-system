CREATE TABLE advised_by (
    PID VARCHAR(255) NOT NULL,
    faculty_name VARCHAR(255) NOT NULL,
    id SERIAL PRIMARY KEY,
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
    VALUES ('A55', 'Jane Doe');