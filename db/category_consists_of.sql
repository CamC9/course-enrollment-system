CREATE TABLE category_consists_of (
    category_name VARCHAR(255) NOT NULL,
    course_name VARCHAR(255) NOT NULL,
    id SERIAL PRIMARY KEY, 
    FOREIGN KEY (course_name) REFERENCES courses(course_name)
);

INSERT INTO category_consists_of (category_name, course_name)
    VALUES ('upper division', 'CSE_132A');
INSERT INTO category_consists_of (category_name, course_name)
    VALUES ('technical elective', 'CSE_291');
INSERT INTO category_consists_of (category_name, course_name)
    VALUES ('lower division', 'CSE_101');
INSERT INTO category_consists_of (category_name, course_name)
    VALUES ('upper division', 'CSE_132B');
