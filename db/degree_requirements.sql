CREATE TABLE degree_requirements (
    degree_name VARCHAR(255) NOT NULL,
    department_name VARCHAR(255) NOT NULL,
    category_name VARCHAR(255),
    concentration_name VARCHAR(255),
    min_units INT NOT NULL,
    min_gpa DECIMAL(3, 2) DEFAULT 0.00,
    id SERIAL PRIMARY KEY,
    FOREIGN KEY (department_name) REFERENCES departments(department_name)
);

INSERT INTO degree_requirements (degree_name, department_name, category_name, min_units, min_gpa)
    VALUES ('BSC IN CS', 'Computer Science', 'Core Courses', 72, 3.00);

INSERT INTO degree_requirements (degree_name, department_name, category_name, min_units, min_gpa)
    VALUES ('BSC IN CS', 'Computer Science', 'Electives', 12, 3.00);

INSERT INTO degree_requirements (degree_name, department_name, category_name, min_units, min_gpa)
    VALUES ('BSC IN COGS', 'Cognitive Science', 'Core Courses', 72, 3.00);

INSERT INTO degree_requirements (degree_name, department_name, category_name, min_units, min_gpa)
    VALUES ('BSC IN COGS', 'Cognitive Science', 'Electives', 12, 3.00);

INSERT INTO degree_requirements (degree_name, department_name, concentration_name, min_units, min_gpa)
    VALUES ('MSC IN CS', 'Computer Science', 'Database', 24, 3.00);

SELECT departments.department_name, total_units_req, degree_requirements.degree_name FROM departments JOIN degree_requirements ON departments.department_name = degree_requirements.department_name WHERE departments.department_name = degree_requirements.department_name;