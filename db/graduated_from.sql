CREATE TABLE graduated_from (
    PID VARCHAR(255) NOT NULL,
    college VARCHAR(255) NOT NULL,
    degree VARCHAR(255) NOT NULL,
    FOREIGN KEY (PID) REFERENCES students(PID)
);

-- Valid PID
INSERT INTO graduated_from (PID, college, degree)
    VALUES ('A99', 'University of Nebraska', 'BS');

-- Valid PID
INSERT INTO graduated_from (PID, college, degree)
    VALUES ('A88', 'University of Nebraska', 'BS');