CREATE TABLE courses (
    course_id int PRIMARY KEY,
    course_name VARCHAR(255) NOT NULL,
    department VARCHAR(255) NOT NULL,
    min_unit INT NOT NULL,
    max_unit INT NOT NULL,
    grading_type VARCHAR(255) NOT NULL,
    requires_lab_work BOOLEAN NOT NULL,
    needs_instructor_consent BOOLEAN NOT NULL,
    FOREIGN KEY (department) REFERENCES departments(department_name)
);

INSERT INTO courses (course_id, course_name, department, min_unit, max_unit, grading_type, requires_lab_work, needs_instructor_consent)
    VALUES (1, 'CSE132A', 'Computer Science', 4, 4, 'letter grade', TRUE, TRUE);
INSERT INTO courses (course_id, course_name, department, min_unit, max_unit, grading_type, requires_lab_work, needs_instructor_consent)
    VALUES (2, 'CSE291', 'Computer Science', 4, 4, 'letter grade or S/U', FALSE, FALSE);
INSERT INTO courses (course_id, course_name, department, min_unit, max_unit, grading_type, requires_lab_work, needs_instructor_consent)
    VALUES (3, 'CSE101', 'Computer Science', 4, 4, 'letter grade', TRUE, TRUE);
INSERT INTO courses (course_id, course_name, department, min_unit, max_unit, grading_type, requires_lab_work, needs_instructor_consent)
    VALUES (4, 'CSE132B', 'Computer Science', 4, 4, 'letter grade', TRUE, TRUE);
INSERT INTO courses (course_id, course_name, department, min_unit, max_unit, grading_type, requires_lab_work, needs_instructor_consent)
    VALUES (5, 'CSE232A', 'Computer Science', 4, 4, 'letter grade', FALSE, TRUE);
INSERT INTO courses (course_id, course_name, department, min_unit, max_unit, grading_type, requires_lab_work, needs_instructor_consent)
    VALUES (6, 'MATH101', 'Mathematics', 4, 4, 'letter grade', FALSE, FALSE);
INSERT INTO courses (course_id, course_name, department, min_unit, max_unit, grading_type, requires_lab_work, needs_instructor_consent)
    VALUES (7, 'PHYS101', 'Physics', 4, 4, 'letter grade', TRUE, TRUE);
INSERT INTO courses (course_id, course_name, department, min_unit, max_unit, grading_type, requires_lab_work, needs_instructor_consent)
    VALUES (8, 'BIO101', 'Biology', 4, 4, 'letter grade', TRUE, TRUE);
INSERT INTO courses (course_id, course_name, department, min_unit, max_unit, grading_type, requires_lab_work, needs_instructor_consent)
    VALUES (9, 'CHEM101', 'Chemistry', 4, 4, 'letter grade', TRUE, TRUE);
INSERT INTO courses (course_id, course_name, department, min_unit, max_unit, grading_type, requires_lab_work, needs_instructor_consent)
    VALUES (10, 'STAT101', 'Statistics', 4, 4, 'letter grade', FALSE, FALSE);
INSERT INTO courses (course_id, course_name, department, min_unit, max_unit, grading_type, requires_lab_work, needs_instructor_consent)
    VALUES (11, 'CSE132C', 'Computer Science', 4, 4, 'letter grade', FALSE, FALSE);
INSERT INTO courses (course_id, course_name, department, min_unit, max_unit, grading_type, requires_lab_work, needs_instructor_consent)
    VALUES (12, 'CSE291B', 'Computer Science', 4, 4, 'letter grade', FALSE, FALSE);