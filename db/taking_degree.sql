CREATE TABLE taking_degree (
    PID VARCHAR(255) NOT NULL,
    degree_name VARCHAR(255) NOT NULL,
    department VARCHAR(255) NOT NULL,
    id SERIAL PRIMARY KEY,
    FOREIGN KEY (PID) REFERENCES students(PID),
    FOREIGN KEY (department) REFERENCES departments(department_name)
);

INSERT INTO taking_degree (PID, degree_name, department)
    VALUES ('1', 'BSC IN CS', 'Computer Science');
INSERT INTO taking_degree (PID, degree_name, department)
    VALUES ('2', 'BSC IN COGS', 'Cognitive Science');
INSERT INTO taking_degree (PID, degree_name, department)
    VALUES ('3', 'MSC IN COGS', 'Cognitive Science');