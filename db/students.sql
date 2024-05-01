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
    department VARCHAR(255),
    FOREIGN KEY (department) REFERENCES departments(department_name)
);

INSERT INTO students (PID, SSN, first, middle, last, college, residency, is_enrolled, graduate_status, department) 
    VALUES ('A12', '111223333', 'John', 'Doe', 'Smith', 'Warren', 'In-State', TRUE, 'Undergraduate', NULL);
INSERT INTO students (PID, SSN, first, middle, last, college, residency, is_enrolled, graduate_status, department) 
    VALUES ('555', '123456789', 'John', 'Rain', 'Hamm', NULL, 'Out-of-State', TRUE, 'BSMS', 'Cognitive Science');

-- Add a student with college when student is a graduate student for testing
    