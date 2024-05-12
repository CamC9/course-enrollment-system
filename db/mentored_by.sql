CREATE TABLE mentored_by (
    PID VARCHAR(255) NOT NULL,
    faculty_name VARCHAR(255) NOT NULL,
    mentorship_type VARCHAR(255) NOT NULL,
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    id SERIAL PRIMARY KEY, 
    FOREIGN KEY (PID) REFERENCES students(PID),
    FOREIGN KEY (faculty_name) REFERENCES faculty(name)
);

-- Valid PID and faculty_name
INSERT INTO mentored_by (PID, faculty_name, mentorship_type, start_date, end_date)
    VALUES ('A88', 'Jackson Doe', 'Research', '2018-01-01', '2022-01-01');

-- Invalid faculty_name
INSERT INTO mentored_by (PID, faculty_name, mentorship_type, start_date, end_date)
    VALUES ('A99', 'Jin Doe', 'Research', '2018-01-01', '2022-01-01');