CREATE TABLE students (
    PID INT PRIMARY KEY,
    SSN VARCHAR(255) NOT NULL,
    first VARCHAR(255) NOT NULL,
    middle VARCHAR(255),
    last VARCHAR(255) NOT NULL,
    college VARCHAR(255) NOT NULL
);

INSERT INTO students (PID, SSN, first, middle, last, college) VALUES (12, '111-22-3333', 'John', 'Doe', 'Smith', 'Warren');
INSERT INTO students (PID, SSN, first, middle, last, college) VALUES (100, '123-45-6789', 'John', 'Rain', 'Hamm', 'Muir');