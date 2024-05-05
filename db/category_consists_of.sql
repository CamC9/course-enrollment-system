CREATE TABLE category_consists_of (
    category_name VARCHAR(255) NOT NULL,
    course_name VARCHAR(255) NOT NULL,
    PRIMARY KEY (category_name, course_name),
    FOREIGN KEY (category_name) REFERENCES category(category_name),
    FOREIGN KEY (course_name) REFERENCES courses(course_name)
);

-- Valid category_name and course_name
INSERT INTO category_consists_of (category_name, course_name)
    VALUES ('Core Courses', 'CSE_132B');

-- Invalid category_name
INSERT INTO category_consists_of (category_name, course_name)
    VALUES ('NOT_A_CATEGORY_NAME', 'CSE_132B');

-- Invalid course_name
INSERT INTO category_consists_of (category_name, course_name)
    VALUES ('Core Courses', 'NOT_A_COURSE_NAME');

-- Second course_name for same category_name
INSERT INTO category_consists_of (category_name, course_name)
    VALUES ('Core Courses', 'CSE_156');

-- Second category_name for same course_name
INSERT INTO category_consists_of (category_name, course_name)
    VALUES ('Electives', 'CSE_132B');