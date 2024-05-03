CREATE TABLE section_meetings (
    class_title VARCHAR(255),
    section_id int PRIMARY KEY,
    meeting_type VARCHAR(255) NOT NULL,
    building_and_room VARCHAR(255) NOT NULL,
    start_time TIME NOT NULL,
    end_time TIME NOT NULL,
    date DATE NOT NULL, 
    is_recurring BOOLEAN NOT NULL,
    FOREIGN KEY (setion_id) REFERENCES sections(section_id)
);

-- Valid entry
INSERT INTO classes (course_name, class_title, year, quarter, offering_id)
    VALUES ('CSE_132B', 'Database Systems Applications', 2018, 'SPRING', 'John Doe' 1);
