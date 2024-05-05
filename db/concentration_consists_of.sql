CREATE TABLE concentration_consists_of (
    concentration_name VARCHAR(255) NOT NULL,
    course_name VARCHAR(255) NOT NULL,
    PRIMARY KEY (concentration_name, course_name),
    FOREIGN KEY (concentration_name) REFERENCES concentration(concentration_name),
    FOREIGN KEY (course_name) REFERENCES courses(course_name)
);

-- Valid concentration_name and course_name
INSERT INTO concentration_consists_of (concentration_name, course_name)
    VALUES ('Database', 'CSE_132B');

-- Second course_name for same concentration_name
INSERT INTO concentration_consists_of (concentration_name, course_name)
    VALUES ('Database', 'CSE_156');

