CREATE TABLE courses (
    course_name int PRIMARY KEY,
    department VARCHAR(255) NOT NULL,
    needs_instructor_consent BOOLEAN NOT NULL,
    requires_lab_work BOOLEAN NOT NULL,
    min_unit int NOT NULL,
    max_unit int NOT NULL,
    grading_type NOT NULL,
    FOREIGN KEY (department) REFERENCES departments(department_name)
);

-- Valid teacher
INSERT INTO courses (course_name, department, needs_instructor_consent, requires_lab_work, min_unit, max_unit, grading_type) 
    VALUES ('CSE_132B', 'Computer Science', TRUE, TRUE, 4, 4);
-- Invalid Department
INSERT INTO courses (course_name, department, needs_instructor_consent, requires_lab_work, min_unit, max_unit, grading_type) 
    VALUES ('CSE_156', 'NOT_A_DEPARTMENT', TRUE, TRUE, 4, 4);
-- Duplicate Course_Name
INSERT INTO courses (course_name, department, needs_instructor_consent, requires_lab_work, min_unit, max_unit, grading_type) 
    VALUES ('CSE_132B', 'Computer Science', TRUE, TRUE, 4, 4);
