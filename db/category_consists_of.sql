CREATE TABLE category_consists_of (
    category_name VARCHAR(255) NOT NULL,
    course_name VARCHAR(255) NOT NULL,
    id SERIAL PRIMARY KEY, 
    FOREIGN KEY (course_name) REFERENCES courses(course_name)
);

INSERT INTO category_consists_of (category_name, course_name)
    VALUES ('upper division', 'CSE132A');
INSERT INTO category_consists_of (category_name, course_name)
    VALUES ('technical elective', 'CSE291');
INSERT INTO category_consists_of (category_name, course_name)
    VALUES ('lower division', 'CSE101');
INSERT INTO category_consists_of (category_name, course_name)
    VALUES ('upper division', 'CSE132B');
INSERT INTO category_consists_of (category_name, course_name)
    VALUES ('technical elective', 'CSE132B');
INSERT INTO category_consists_of (category_name, course_name)
    VALUES ('technical elective', 'CSE232A');
INSERT INTO category_consists_of (category_name, course_name)
    VALUES ('lower division', 'MATH101');
INSERT INTO category_consists_of (category_name, course_name)
    VALUES ('lower division', 'PHYS101');
INSERT INTO category_consists_of (category_name, course_name)
    VALUES ('lower division', 'BIO101');
INSERT INTO category_consists_of (category_name, course_name)
    VALUES ('lower division', 'CHEM101');
INSERT INTO category_consists_of (category_name, course_name)
    VALUES ('lower division', 'STAT101');
INSERT INTO category_consists_of (category_name, course_name)
    VALUES ('lower division', 'CSE132C');
INSERT INTO category_consists_of (category_name, course_name)
    VALUES ('lower division', 'CSE291B');
