CREATE TABLE departments (
    department_name VARCHAR(255) PRIMARY KEY,
    total_units_req INT NOT NULL,
    lower_div_units_req INT NOT NULL
);

-- Valid entry
INSERT INTO departments (department_name, total_units_req, lower_div_units_req) 
    VALUES ('Computer Science', 120, 48);

-- Second valid entry
INSERT INTO departments (department_name, total_units_req, lower_div_units_req) 
    VALUES ('Cognitive Science', 96, 48);  

-- Third valid entry
INSERT INTO departments (department_name, total_units_req, lower_div_units_req) 
    VALUES ('Mathematics', 160, 32);