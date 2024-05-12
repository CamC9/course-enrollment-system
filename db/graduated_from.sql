CREATE TABLE graduated_from (
    PID VARCHAR(255) NOT NULL,
    college VARCHAR(255) NOT NULL,
    degree VARCHAR(255) NOT NULL,
    id SERIAL PRIMARY KEY,
    FOREIGN KEY (PID) REFERENCES students(PID)
);

INSERT INTO graduated_from (PID, college, degree)
    VALUES ('A99', 'University of Nebraska', 'BSC IN CS');

INSERT INTO graduated_from (PID, college, degree)
    VALUES ('A88', 'University of Nebraska', 'BSC IN COGS');

