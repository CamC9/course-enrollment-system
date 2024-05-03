CREATE TABLE taking_degree (
    PID VARCHAR(255) NOT NULL,
    degree_type VARCHAR(255) NOT NULL,
    department VARCHAR(255) NOT NULL,
    FOREIGN KEY (PID) REFERENCES students(PID),
    FOREIGN KEY (department) REFERENCES department(department_name)
);

-- Valid PID and department
INSERT INTO taking_degree (PID, degree_type, department)
    VALUES ('A99', 'BS', 'Computer Science');

-- Invalid PID
INSERT INTO taking_degree (PID, degree_type, department)
    VALUES ('NOT_A_PID', 'BS', 'Computer Science');

-- Invalid department
INSERT INTO taking_degree (PID, degree_type, department)
    VALUES ('A99', 'BS', 'NOT_A_DEPARTMENT');