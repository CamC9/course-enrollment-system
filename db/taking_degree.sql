CREATE TABLE taking_degree (
    PID VARCHAR(255) NOT NULL,
    degree_name VARCHAR(255) NOT NULL,
    department VARCHAR(255) NOT NULL,
    id SERIAL PRIMARY KEY,
    FOREIGN KEY (PID) REFERENCES students(PID),
    FOREIGN KEY (department) REFERENCES departments(department_name)
);

-- Valid PID and department
INSERT INTO taking_degree (PID, degree_name, department)
    VALUES ('A99', 'BSC IN CS', 'Computer Science');

-- Different student, same department
INSERT INTO taking_degree (PID, degree_name, department)
    VALUES ('A88', 'BSC IN COGS', 'Cognitive Science');

-- Different student, different department
INSERT INTO taking_degree (PID, degree_name, department)
    VALUES ('A77', 'MSC IN COGS', 'Cognitive Science');