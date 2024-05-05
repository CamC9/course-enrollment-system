CREATE TABLE mentored_by (
    PID VARCHAR(255) NOT NULL,
    faculty_name VARCHAR(255) NOT NULL,
    mentorship_type VARCHAR(255) NOT NULL,
    start_term_date DATE NOT NULL,
    end_term_date DATE NOT NULL,
    PRIMARY KEY (PID, faculty_name),
    FOREIGN KEY (PID) REFERENCES students(PID),
    FOREIGN KEY (faculty_name) REFERENCES faculty(name)
);

-- Valid PID and faculty_name
INSERT INTO mentored_by (PID, faculty_name, mentorship_type, start_term_date, end_term_date)
    VALUES ('A88', 'Jackson Doe', 'Research', '2018-01-01', '2022-01-01');

-- Invalid faculty_name
INSERT INTO mentored_by (PID, faculty_name, mentorship_type, start_term_date, end_term_date)
    VALUES ('A99', 'Jin Doe', 'Research', '2018-01-01', '2022-01-01');