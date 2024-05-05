CREATE TABLE courses (
    course_name VARCHAR(255) PRIMARY KEY,
    department VARCHAR(255) NOT NULL,
    needs_instructor_consent BOOLEAN NOT NULL,
    requires_lab_work BOOLEAN NOT NULL,
    min_unit INT NOT NULL,
    max_unit INT NOT NULL,
    grading_type VARCHAR(255) NOT NULL,
    FOREIGN KEY (department) REFERENCES departments(department_name)
);

-- Valid entry
INSERT INTO courses (course_name, department, needs_instructor_consent, requires_lab_work, min_unit, max_unit, grading_type) 
    VALUES ('CSE_132B', 'Computer Science', TRUE, TRUE, 4, 4, 'Letter');

-- Second valid entry
INSERT INTO courses (course_name, department, needs_instructor_consent, requires_lab_work, min_unit, max_unit, grading_type) 
    VALUES ('CSE_156', 'Computer Science', TRUE, TRUE, 4, 4, 'Both');

-- Third valid entry
INSERT INTO courses (course_name, department, needs_instructor_consent, requires_lab_work, min_unit, max_unit, grading_type) 
    VALUES ('COGS_112', 'Cognitive Science', FALSE, FALSE, 4, 4, 'S/U');