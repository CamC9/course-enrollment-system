CREATE TABLE class_sections (
    class_offering_id INT NOT NULL,
    instructor VARCHAR(255) NOT NULL,
    section_id int PRIMARY KEY,
    FOREIGN KEY (class_offering_id) REFERENCES classes(offering_id),
    FOREIGN KEY (instructor) REFERENCES faculty(name)
);

-- Valid entry
INSERT INTO class_sections (class_offering_id, instructor, section_id)
    VALUES (1, 'John Doe', 1);

-- Future class
INSERT INTO class_sections (class_offering_id, instructor, section_id)
    VALUES (5, 'John Doe', 2);

-- Valid entry
INSERT INTO class_sections (class_offering_id, instructor, section_id)
    VALUES (2, 'Jane Doe', 3);