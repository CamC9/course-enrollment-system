CREATE TABLE students (
    PID VARCHAR(255) PRIMARY KEY,
    SSN INT NOT NULL,
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
    VALUES ('A99', '111223333', 'John', 'Doe', 'Smith', 'Warren', 'In-State', TRUE, 'Undergraduate', 'Computer Science', 'Mathematics', NULL);
INSERT INTO students (PID, SSN, first, middle, last, college, residency, is_enrolled, graduate_status, major, minor, department) 
    VALUES ('A88', '123456789', 'John', 'Rain', 'Hamm', NULL, 'Out-of-State', TRUE, 'BSMS', NULL, NULL, 'Cognitive Science');
INSERT INTO students (PID, SSN, first, middle, last, college, residency, is_enrolled, graduate_status, major, minor, department) 
    VALUES ('A77', '987654321', 'Jane', 'Doe', 'Smith', 'Warren', 'In-State', TRUE, 'Undergraduate', 'Mathematics', 'Cognitive Science', NULL);
