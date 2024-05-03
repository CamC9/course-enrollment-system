CREATE TABLE graduated_from (
    PID VARCHAR(255) NOT NULL,
    college VARCHAR(255) NOT NULL,
    degree VARCHAR(255) NOT NULL,
    FOREIGN KEY (PID) REFERENCES students(PID)
);

-- Valid PID
INSERT INTO graduated_from (PID, college, degree)
    VALUES ('A99', 'University of Nebraska', 'BS');

-- Invalid PID
INSERT INTO graduated_from (PID, college, degree)
    VALUES ('NOT_A_PID', 'University of Nebraska', 'BS');