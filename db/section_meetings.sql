CREATE TABLE section_meetings (
    class_title VARCHAR(255),
    section_id int PRIMARY KEY,
    meeting_type VARCHAR(255) NOT NULL,
    building_and_room VARCHAR(255) NOT NULL,
    start_time TIME NOT NULL,
    end_time TIME NOT NULL,
    date DATE NOT NULL, 
    is_recurring BOOLEAN NOT NULL,
    FOREIGN KEY (section_id) REFERENCES class_sections(section_id)
);

-- Valid entry
INSERT INTO section_meetings (class_title, section_id, meeting_type, building_and_room, start_time, end_time, date, is_recurring)
    VALUES ('Database Systems Applications', 1, 'Lecture', 'CSB 130', '10:00:00', '11:50:00', '2018-04-02', TRUE);

-- Valid entry for different section
INSERT INTO section_meetings (class_title, section_id, meeting_type, building_and_room, start_time, end_time, date, is_recurring)
    VALUES ('Database Systems Applications', 2, 'Lecture', 'CSB 130', '10:00:00', '11:50:00', '2018-04-02', TRUE);