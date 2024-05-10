CREATE TABLE delegates_committee (
    PID VARCHAR(255) NOT NULL,
    faculty_name VARCHAR(255) NOT NULL,
    id SERIAL PRIMARY KEY,
    FOREIGN KEY (PID) REFERENCES students(PID),
    FOREIGN KEY (faculty_name) REFERENCES faculty(name)
);

-- Valid entry
INSERT INTO delegates_committee (PID, faculty_name)
    VALUES ('A99', 'Jin Doe');

-- Valid entry
INSERT INTO delegates_committee (PID, faculty_name)
    VALUES ('A99', 'Jackson Doe');

-- Other student valid entry
INSERT INTO delegates_committee (PID, faculty_name)
    VALUES ('A88', 'Jackson Doe');