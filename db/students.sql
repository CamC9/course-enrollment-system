CREATE TABLE students (
    PID VARCHAR(255) PRIMARY KEY,
    SSN VARCHAR(255) NOT NULL,
    first VARCHAR(255) NOT NULL,
    middle VARCHAR(255),
    last VARCHAR(255) NOT NULL,
    college VARCHAR(255),
    residency VARCHAR(255) NOT NULL,
    is_enrolled BOOLEAN NOT NULL,
    graduate_status VARCHAR(255) NOT NULL,
    major VARCHAR(255),
    minor VARCHAR(255),
    department VARCHAR(255)
);

INSERT INTO students (PID, SSN, first, middle, last, college, residency, is_enrolled, graduate_status, major, minor, department) 
    VALUES ('1', '123-45-6789', 'John', 'A', 'Doe', 'Unknown', 'Unknown', TRUE, 'Undergraduate', 'Unknown', 'Unknown', NULL);
INSERT INTO students (PID, SSN, first, middle, last, college, residency, is_enrolled, graduate_status, major, minor, department) 
    VALUES ('2', '987-65-4321', 'Jane', 'B', 'Smith', 'Unknown', 'Unknown', TRUE, 'Postgraduate', 'Unknown', 'Unknown', NULL);
INSERT INTO students (PID, SSN, first, middle, last, college, residency, is_enrolled, graduate_status, major, minor, department) 
    VALUES ('3', '567-89-1234', 'Alice', 'C', 'Johnson', 'Unknown', 'Unknown', TRUE, 'Undergraduate', 'Unknown', 'Unknown', NULL);
INSERT INTO students (PID, SSN, first, middle, last, college, residency, is_enrolled, graduate_status, major, minor, department) 
    VALUES ('4', '234-56-7890', 'Bob', 'D', 'Brown', 'Unknown', 'Unknown', TRUE, 'Undergraduate', 'Unknown', 'Unknown', NULL);
INSERT INTO students (PID, SSN, first, middle, last, college, residency, is_enrolled, graduate_status, major, minor, department) 
    VALUES ('5', '345-67-8901', 'Carol', 'E', 'Davis', 'Unknown', 'Unknown', TRUE, 'Undergraduate', 'Unknown', 'Unknown', NULL);
INSERT INTO students (PID, SSN, first, middle, last, college, residency, is_enrolled, graduate_status, major, minor, department) 
    VALUES ('6', '456-78-9012', 'David', 'F', 'Miller', 'Unknown', 'Unknown', TRUE, 'Undergraduate', 'Unknown', 'Unknown', NULL);
INSERT INTO students (PID, SSN, first, middle, last, college, residency, is_enrolled, graduate_status, major, minor, department) 
    VALUES ('7', '567-89-0123', 'Eve', 'G', 'Wilson', 'Unknown', 'Unknown', TRUE, 'Undergraduate', 'Unknown', 'Unknown', NULL);