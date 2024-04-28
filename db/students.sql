CREATE TABLE students (
    PID VARCHAR(255) PRIMARY KEY,
    SSN INT NOT NULL,
    first VARCHAR(255) NOT NULL,
    middle VARCHAR(255),
    last VARCHAR(255) NOT NULL,
    college VARCHAR(255) NOT NULL,
    residency VARCHAR(255) NOT NULL,
    is_enrolled BOOLEAN NOT NULL,
    graduate_status VARCHAR(255) NOT NULL
);

INSERT INTO students (PID, SSN, first, middle, last, college, residency, is_enrolled, graduate_status) 
    VALUES ('A12', '111223333', 'John', 'Doe', 'Smith', 'Warren', 'In-State', TRUE, 'Undergraduate');
INSERT INTO students (PID, SSN, first, middle, last, college, residency, is_enrolled, graduate_status) 
    VALUES ('555', '123456789', 'John', 'Rain', 'Hamm', 'Muir', 'Out-of-State', TRUE, 'BSMS');