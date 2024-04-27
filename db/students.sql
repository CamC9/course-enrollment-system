CREATE TABLE students (
    PID INT PRIMARY KEY,
    SSN VARCHAR(255) NOT NULL,
    first VARCHAR(255) NOT NULL,
    middle VARCHAR(255),
    last VARCHAR(255) NOT NULL,
    college VARCHAR(255) NOT NULL,
    residency VARCHAR(255) NOT NULL,
    is_enrolled BOOLEAN NOT NULL,
    graduate_status VARCHAR(255) NOT NULL
);

INSERT INTO students (PID, SSN, first, middle, last, college, residency, is_enrolled, graduate_status) 
    VALUES (12, '111-22-3333', 'John', 'Doe', 'Smith', 'Warren', 'In-State', TRUE, 'Undergraduate');
INSERT INTO students (PID, SSN, first, middle, last, college, residency, is_enrolled, graduate_status) 
    VALUES (100, '123-45-6789', 'John', 'Rain', 'Hamm', 'Muir', 'Out-of-State', TRUE, 'BSMS');