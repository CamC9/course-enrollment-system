CREATE TABLE department_categories (
    department_name VARCHAR(255) NOT NULL,
    category_name VARCHAR(255) NOT NULL,
    FOREIGN KEY (department_name) REFERENCES departments(department_name),
    FOREIGN KEY (category_name) REFERENCES category(category_name),
    PRIMARY KEY (department_name, category_name)
);

-- Valid entry
INSERT INTO department_categories (department_name, category_name)
    VALUES ('Computer Science', 'Core Courses');

-- Second valid entry
INSERT INTO department_categories (department_name, category_name)
    VALUES ('Computer Science', 'Electives');

-- Third valid entry
INSERT INTO department_categories (department_name, category_name)
    VALUES ('Cognitive Science', 'Core Courses');

-- Fourth valid entry
INSERT INTO department_categories (department_name, category_name)
    VALUES ('Cognitive Science', 'Electives');