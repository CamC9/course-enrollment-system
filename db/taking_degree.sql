CREATE TABLE taking_degree (
    PID VARCHAR(255) NOT NULL,
    degree_type VARCHAR(255) NOT NULL,
    department VARCHAR(255) NOT NULL,
    FOREIGN KEY (PID) REFERENCES students(PID),
    FOREIGN KEY (department) REFERENCES departments(department_name)
);

-- Valid PID and department
INSERT INTO taking_degree (PID, degree_type, department)
    VALUES ('A99', 'BS', 'Computer Science');

-- Different student, same department
INSERT INTO taking_degree (PID, degree_type, department)
    VALUES ('A88', 'BS', 'Computer Science');

-- Different student, different department
INSERT INTO taking_degree (PID, degree_type, department)
    VALUES ('A77', 'BS', 'Cognitive Science');