CREATE TABLE departments (
    department_name VARCHAR(255) PRIMARY KEY,
    total_units_req int NOT NULL,
    lower_div_units_req NOT NULL
);

-- Valid entry
INSERT INTO departments (department_name, total_units_req, lower_div_units_req) 
    VALUES ('Computer Science', 120, 48);

-- Invalid department name
INSERT INTO departments (department_name, total_units_req, lower_div_units_req) 
    VALUES ('NOT_A_DEPARTMENT', 120, 48);  