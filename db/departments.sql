CREATE TABLE departments (
    department_name VARCHAR(255) NOT NULL,
    total_units_req int NOT NULL,
    lower_div_units_req NOT NULL,
    PRIMARY KEY (department_name),
);

-- Valid teacher
INSERT INTO departments (department_name, total_units_req, lower_div_units_req) 
    VALUES ('Computer Science', 120, 48);