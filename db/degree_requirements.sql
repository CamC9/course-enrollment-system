CREATE TABLE degree_requirements (
    degree_name VARCHAR(255) NOT NULL,
    department_name VARCHAR(255) NOT NULL,
    category_name VARCHAR(255) NOT NULL,
    min_units INT NOT NULL,
    id SERIAL PRIMARY KEY,
    FOREIGN KEY (department_name) REFERENCES departments(department_name)
);

INSERT INTO degree_requirements (degree_name, department_name, category_name, min_units)
    VALUES ('BSC in Computer Science', 'Computer Science', 'lower division', 70);
INSERT INTO degree_requirements (degree_name, department_name, category_name, min_units)
    VALUES ('BSC in Computer Science', 'Computer Science', 'upper division', 40);
INSERT INTO degree_requirements (degree_name, department_name, category_name, min_units)
    VALUES ('BSC in Computer Science', 'Computer Science', 'technical elective', 24);
INSERT INTO degree_requirements (degree_name, department_name, category_name, min_units)
    VALUES ('MS in Computer Science', 'Computer Science', 'upper division', 24);
INSERT INTO degree_requirements (degree_name, department_name, category_name, min_units)
    VALUES ('MS in Computer Science', 'Computer Science', 'technical elective', 20);
INSERT INTO degree_requirements (degree_name, department_name, category_name, min_units)
    VALUES ('BSC in Mathematics', 'Mathematics', 'lower division', 60);
INSERT INTO degree_requirements (degree_name, department_name, category_name, min_units)
    VALUES ('BSC in Mathematics', 'Mathematics', 'upper division', 40);
INSERT INTO degree_requirements (degree_name, department_name, category_name, min_units)
    VALUES ('BSC in Mathematics', 'Mathematics', 'technical elective', 20);
INSERT INTO degree_requirements (degree_name, department_name, category_name, min_units)
    VALUES ('BSC in Physics', 'Physics', 'lower division', 60);
INSERT INTO degree_requirements (degree_name, department_name, category_name, min_units)
    VALUES ('BSC in Physics', 'Physics', 'upper division', 40);
INSERT INTO degree_requirements (degree_name, department_name, category_name, min_units)
    VALUES ('BSC in Physics', 'Physics', 'technical elective', 20);
INSERT INTO degree_requirements (degree_name, department_name, category_name, min_units)
    VALUES ('BSC in Biology', 'Biology', 'lower division', 60);
INSERT INTO degree_requirements (degree_name, department_name, category_name, min_units)
    VALUES ('BSC in Biology', 'Biology', 'upper division', 40);
INSERT INTO degree_requirements (degree_name, department_name, category_name, min_units)
    VALUES ('BSC in Biology', 'Biology', 'technical elective', 20);
INSERT INTO degree_requirements (degree_name, department_name, category_name, min_units)
    VALUES ('BSC in Chemistry', 'Chemistry', 'lower division', 60);
INSERT INTO degree_requirements (degree_name, department_name, category_name, min_units)
    VALUES ('BSC in Chemistry', 'Chemistry', 'upper division', 40);
INSERT INTO degree_requirements (degree_name, department_name, category_name, min_units)
    VALUES ('BSC in Chemistry', 'Chemistry', 'technical elective', 20);
INSERT INTO degree_requirements (degree_name, department_name, category_name, min_units)
    VALUES ('BSC in Statistics', 'Statistics', 'lower division', 60);
INSERT INTO degree_requirements (degree_name, department_name, category_name, min_units)
    VALUES ('BSC in Statistics', 'Statistics', 'upper division', 40);
INSERT INTO degree_requirements (degree_name, department_name, category_name, min_units)
    VALUES ('BSC in Statistics', 'Statistics', 'technical elective', 20);