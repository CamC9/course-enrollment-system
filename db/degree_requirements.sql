CREATE TABLE degree_requirements (
    degree_name VARCHAR(255) NOT NULL,
    department_name VARCHAR(255) NOT NULL,
    category_name VARCHAR(255),
    concentration_name VARCHAR(255),
    id SERIAL PRIMARY KEY,
    FOREIGN KEY (degree_name) REFERENCES degrees(degree_name),
    FOREIGN KEY (department_name) REFERENCES departments(department_name),
    FOREIGN KEY (category_name) REFERENCES category(category_name),
    FOREIGN KEY (concentration_name) REFERENCES concentration(concentration_name)
);

-- Valid entry
INSERT INTO degree_requirements (degree_name, department_name, category_name)
    VALUES ('BSC IN CS', 'Computer Science', 'Core Courses');

-- Second valid entry
INSERT INTO degree_requirements (degree_name, department_name, category_name)
    VALUES ('BSC IN CS', 'Computer Science', 'Electives');

-- Third valid entry
INSERT INTO degree_requirements (degree_name, department_name, category_name)
    VALUES ('BSC IN COGS', 'Cognitive Science', 'Core Courses');

-- Fourth valid entry
INSERT INTO degree_requirements (degree_name, department_name, category_name)
    VALUES ('BSC IN COGS', 'Cognitive Science', 'Electives');

-- Valid Graduate entry
INSERT INTO degree_requirements (degree_name, department_name, concentration_name)
    VALUES ('MSC IN CS', 'Computer Science', 'Database');