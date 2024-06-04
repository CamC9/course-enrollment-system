CREATE TABLE departments (
    department_name VARCHAR(255) PRIMARY KEY,
    total_units_req INT NOT NULL,
    lower_div_units_req INT NOT NULL,
    upper_div_units_req INT NOT NULL,
    technical_elective_units_req INT NOT NULL
);

INSERT INTO departments (department_name, total_units_req, lower_div_units_req, upper_div_units_req, technical_elective_units_req) 
    VALUES ('Computer Science', 134, 70, 40, 24);
INSERT INTO departments (department_name, total_units_req, lower_div_units_req, upper_div_units_req, technical_elective_units_req) 
    VALUES ('Mathematics', 120, 60, 40, 20);
INSERT INTO departments (department_name, total_units_req, lower_div_units_req, upper_div_units_req, technical_elective_units_req) 
    VALUES ('Physics', 120, 60, 40, 20);
INSERT INTO departments (department_name, total_units_req, lower_div_units_req, upper_div_units_req, technical_elective_units_req) 
    VALUES ('Biology', 120, 60, 40, 20);
INSERT INTO departments (department_name, total_units_req, lower_div_units_req, upper_div_units_req, technical_elective_units_req) 
    VALUES ('Chemistry', 120, 60, 40, 20);
INSERT INTO departments (department_name, total_units_req, lower_div_units_req, upper_div_units_req, technical_elective_units_req) 
    VALUES ('Statistics', 120, 60, 40, 20);