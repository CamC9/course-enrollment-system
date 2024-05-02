CREATE TABLE departments (
    department_name VARCHAR(255) PRIMARY KEY,
    total_units_req int NOT NULL,
    lower_div_units_req NOT NULL,
);

-- Valid teacher
INSERT INTO departments (department_name, total_units_req, lower_div_units_req) 
    VALUES ('Computer Science', 120, 48);