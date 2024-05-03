CREATE TABLE sections (
    course_name VARCHAR(255) NOT NULL,
    class_title VARCHAR(255) NOT NULL,
    year int NOT NULL,
    quarter VARCHAR(255) NOT NULL,
    instructor VARCHAR(255) NOT NULL,
    section_id int PRIMARY KEY,
    FOREIGN KEY (course_name) REFERENCES courses(course_name),
    FOREIGN KEY (instructor) REFERENCES instructors(instructor_name)
);

-- Valid entriess
INSERT INTO classes (course_name, class_title, year, quarter, offering_id)
    VALUES ('CSE_132B', 'Database Systems Applications', 2018, 'SPRING', 'John Doe' 1);

-- Future class
INSERT INTO classes (course, class_title, year, quarter, offering_id)
    VALUES ('CSE_156', 'Statistical Natural Language Processing', 2020, 'SPRING', 'John Doe', 1);
