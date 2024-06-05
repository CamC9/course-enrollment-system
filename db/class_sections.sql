CREATE TABLE class_sections (
    course_name VARCHAR(255) NOT NULL,
    class_offering_id INT NOT NULL,
    instructor VARCHAR(255) NOT NULL,
    enrollment_cap INT NOT NULL,
    section_id VARCHAR(255) PRIMARY KEY,
    FOREIGN KEY (course_name) REFERENCES courses(course_name),
    FOREIGN KEY (class_offering_id) REFERENCES classes(offering_id),
    FOREIGN KEY (instructor) REFERENCES faculty(name)
);

INSERT INTO class_sections (section_id, class_offering_id, instructor, enrollment_cap, course_name) 
    VALUES ('S1', 1, 'Dr. Alan Turing', 25, 'CSE132A');
INSERT INTO class_sections (section_id, class_offering_id, instructor, enrollment_cap, course_name) 
    VALUES ('S2', 2, 'Dr. Ada Lovelace', 25, 'CSE291');
INSERT INTO class_sections (section_id, class_offering_id, instructor, enrollment_cap, course_name) 
    VALUES ('S3', 3, 'Dr. Andrew Ng', 25, 'CSE101');
INSERT INTO class_sections (section_id, class_offering_id, instructor, enrollment_cap, course_name) 
    VALUES ('S4', 4, 'Dr. Alan Turing', 25, 'CSE132B');
INSERT INTO class_sections (section_id, class_offering_id, instructor, enrollment_cap, course_name) 
    VALUES ('S5', 5, 'Dr. Geoffrey Hinton', 25, 'CSE232A');
INSERT INTO class_sections (section_id, class_offering_id, instructor, enrollment_cap, course_name) 
    VALUES ('S6', 6, 'Dr. Carl Gauss', 25, 'MATH101');
INSERT INTO class_sections (section_id, class_offering_id, instructor, enrollment_cap, course_name) 
    VALUES ('S7', 7, 'Dr. Albert Einstein', 25, 'PHYS101');
INSERT INTO class_sections (section_id, class_offering_id, instructor, enrollment_cap, course_name) 
    VALUES ('S8', 8, 'Dr. James Watson', 25, 'BIO101');
INSERT INTO class_sections (section_id, class_offering_id, instructor, enrollment_cap, course_name) 
    VALUES ('S9', 9, 'Dr. Marie Curie', 25, 'CHEM101');
INSERT INTO class_sections (section_id, class_offering_id, instructor, enrollment_cap, course_name) 
    VALUES ('S10', 10, 'Dr. John Tukey', 25, 'STAT101');
INSERT INTO class_sections (section_id, class_offering_id, instructor, enrollment_cap, course_name) 
    VALUES ('S11', 11, 'Dr. Alan Turing', 25, 'CSE132A');
INSERT INTO class_sections (section_id, class_offering_id, instructor, enrollment_cap, course_name) 
    VALUES ('S12', 12, 'Dr. Ian Goodfellow', 25, 'CSE291B');
INSERT INTO class_sections (section_id, class_offering_id, instructor, enrollment_cap, course_name) 
    VALUES ('S13', 13, 'Dr. Alin D', 25, 'CSE132C');