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

INSERT INTO courses (course_name, department, needs_instructor_consent, requires_lab_work, min_unit, max_unit, grading_type)
    VALUES ('CSE132A', 'Computer Science', TRUE, TRUE, 4, 4, 'letter grade');
INSERT INTO courses (course_name, department, needs_instructor_consent, requires_lab_work, min_unit, max_unit, grading_type) 
    VALUES ('CSE291', 'Computer Science', FALSE, FALSE, 4, 4, 'letter grade or S/U');
INSERT INTO courses (course_name, department, needs_instructor_consent, requires_lab_work, min_unit, max_unit, grading_type) 
    VALUES ('CSE101', 'Computer Science', TRUE, TRUE, 4, 4, 'letter grade');
INSERT INTO courses (course_name, department, needs_instructor_consent, requires_lab_work, min_unit, max_unit, grading_type) 
    VALUES ('CSE132B', 'Computer Science', TRUE, TRUE, 4, 4, 'letter grade');
INSERT INTO courses (course_name, department, needs_instructor_consent, requires_lab_work, min_unit, max_unit, grading_type) 
    VALUES ('CSE232A', 'Computer Science', TRUE, FALSE, 4, 4, 'letter grade');
INSERT INTO courses (course_name, department, needs_instructor_consent, requires_lab_work, min_unit, max_unit, grading_type) 
    VALUES ('MATH101', 'Mathematics', FALSE, FALSE, 4, 4, 'letter grade');
INSERT INTO courses (course_name, department, needs_instructor_consent, requires_lab_work, min_unit, max_unit, grading_type) 
    VALUES ('PHYS101', 'Physics', TRUE, TRUE, 4, 4, 'letter grade');
INSERT INTO courses (course_name, department, needs_instructor_consent, requires_lab_work, min_unit, max_unit, grading_type) 
    VALUES ('BIO101', 'Biology', TRUE, TRUE, 4, 4, 'letter grade');
INSERT INTO courses (course_name, department, needs_instructor_consent, requires_lab_work, min_unit, max_unit, grading_type) 
    VALUES ('CHEM101', 'Chemistry', TRUE, TRUE, 4, 4, 'letter grade');
INSERT INTO courses (course_name, department, needs_instructor_consent, requires_lab_work, min_unit, max_unit, grading_type) 
    VALUES ('STAT101', 'Statistics', FALSE, FALSE, 4, 4, 'letter grade');
INSERT INTO courses (course_name, department, needs_instructor_consent, requires_lab_work, min_unit, max_unit, grading_type) 
    VALUES ('CSE132C', 'Computer Science', FALSE, FALSE, 4, 4, 'letter grade');
INSERT INTO courses (course_name, department, needs_instructor_consent, requires_lab_work, min_unit, max_unit, grading_type) 
    VALUES ('CSE291B', 'Computer Science', FALSE, FALSE, 4, 4, 'letter grade');