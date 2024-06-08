CREATE TABLE class_sections (
    section_id VARCHAR(255) PRIMARY KEY,
    class_id INT NOT NULL,
    instructor VARCHAR(255) NOT NULL,
    enrollment_cap INT NOT NULL,
    FOREIGN KEY (class_id) REFERENCES classes(class_id),
    FOREIGN KEY (instructor) REFERENCES faculty(name)
);

INSERT INTO class_sections (section_id, class_id, instructor, enrollment_cap) 
    VALUES ('S1', 1, 'Dr. Alan Turing', 25);
INSERT INTO class_sections (section_id, class_id, instructor, enrollment_cap) 
    VALUES ('S2', 2, 'Dr. Ada Lovelace', 25);
INSERT INTO class_sections (section_id, class_id, instructor, enrollment_cap) 
    VALUES ('S3', 3, 'Dr. Andrew Ng', 25);
INSERT INTO class_sections (section_id, class_id, instructor, enrollment_cap) 
    VALUES ('S4', 4, 'Dr. Alan Turing', 25);
INSERT INTO class_sections (section_id, class_id, instructor, enrollment_cap) 
    VALUES ('S5', 5, 'Dr. Geoffrey Hinton', 25);
INSERT INTO class_sections (section_id, class_id, instructor, enrollment_cap) 
    VALUES ('S6', 6, 'Dr. Carl Gauss', 25);
INSERT INTO class_sections (section_id, class_id, instructor, enrollment_cap) 
    VALUES ('S7', 7, 'Dr. Albert Einstein', 25);
INSERT INTO class_sections (section_id, class_id, instructor, enrollment_cap) 
    VALUES ('S8', 8, 'Dr. James Watson', 25);
INSERT INTO class_sections (section_id, class_id, instructor, enrollment_cap) 
    VALUES ('S9', 9, 'Dr. Marie Curie', 25);
INSERT INTO class_sections (section_id, class_id, instructor, enrollment_cap) 
    VALUES ('S10', 10, 'Dr. John Tukey', 25);
INSERT INTO class_sections (section_id, class_id, instructor, enrollment_cap) 
    VALUES ('S11', 11, 'Dr. Alan Turing', 25);
INSERT INTO class_sections (section_id, class_id, instructor, enrollment_cap) 
    VALUES ('S12', 12, 'Dr. Ian Goodfellow', 25);
INSERT INTO class_sections (section_id, class_id, instructor, enrollment_cap) 
    VALUES ('S13', 13, 'Dr. Alin D', 25);