CREATE TABLE class_sections (
    course_name VARCHAR(255) NOT NULL,
    class_offering_id INT NOT NULL,
    instructor VARCHAR(255) NOT NULL,
    enrollment_cap INT NOT NULL,
    section_id int PRIMARY KEY,
    FOREIGN KEY (course_name) REFERENCES courses(course_name),
    FOREIGN KEY (class_offering_id) REFERENCES classes(offering_id),
    FOREIGN KEY (instructor) REFERENCES faculty(name)
);

-- Valid entry
INSERT INTO class_sections (course_name, class_offering_id, instructor, enrollment_cap, section_id)
    VALUES ('CSE_132B', 1, 'John Doe', 25, 1);

-- Future class
INSERT INTO class_sections (course_name, class_offering_id, instructor, enrollment_cap, section_id)
    VALUES ('CSE_156', 5, 'John Doe', 6, 2);

-- Valid entry
INSERT INTO class_sections (course_name, class_offering_id, instructor, enrollment_cap, section_id)
    VALUES ('COGS_112', 2, 'Jane Doe', 20, 3);

-- Valid entry
INSERT INTO class_sections (course_name, class_offering_id, instructor, enrollment_cap, section_id)
    VALUES ('CSE_156', 10, 'Jane Doe', 4, 10);

-- Valid entry
INSERT INTO class_sections (course_name, class_offering_id, instructor, enrollment_cap, section_id)
    VALUES ('CSE_156', 11, 'Jane Doe', 2, 11);

-- Valid entry
INSERT INTO class_sections (course_name, class_offering_id, instructor, enrollment_cap, section_id)
    VALUES ('CSE_132B', 12, 'Jane Doe', 25, 12);