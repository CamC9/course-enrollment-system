CREATE TABLE review_sessions (
    section_id VARCHAR(255) NOT NULL,
    start_time TIME NOT NULL,
    end_time TIME NOT NULL,
    date DATE NOT NULL,
    building_and_room VARCHAR(255) NOT NULL,
    meeting_id SERIAL PRIMARY KEY,
    FOREIGN KEY (section_id) REFERENCES class_sections(section_id)
);

INSERT INTO review_sessions (section_id, start_time, end_time, date, building_and_room)
    VALUES ('S1', '10:00', '11:00', '2020-01-01', 'CSB 130');