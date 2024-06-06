CREATE TABLE category_consists_of (
    degree_name VARCHAR(255) NOT NULL,
    category_name VARCHAR(255) NOT NULL,
    course_name VARCHAR(255) NOT NULL,
    id SERIAL PRIMARY KEY, 
    FOREIGN KEY (course_name) REFERENCES courses(course_name)
);

-- Valid category_name and course_name
INSERT INTO category_consists_of (degree_name, category_name, course_name)
    VALUES ('BSC IN CS', 'Core Courses', 'CSE_132B');

-- Valid category_name and course_name
INSERT INTO category_consists_of (degree_name, category_name, course_name)
    VALUES ('BSC IN COGS', 'Core Courses', 'COGS_112');

-- Second course_name for same category_name
INSERT INTO category_consists_of (degree_name, category_name, course_name)
    VALUES ('BSC IN CS', 'Core Courses', 'CSE_156');

-- Second category_name for same course_name
INSERT INTO category_consists_of (degree_name, category_name, course_name)
    VALUES ('BSC IN CS', 'Electives', 'CSE_132B');