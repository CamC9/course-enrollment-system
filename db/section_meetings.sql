CREATE TABLE section_meetings (
    section_id VARCHAR(255) NOT NULL,
    meeting_type VARCHAR(255) NOT NULL,
    start_time TIME NOT NULL,
    end_time TIME NOT NULL,
    days_of_week VARCHAR(255),
    building_and_room VARCHAR(255) NOT NULL,
    meeting_id SERIAL PRIMARY KEY,
    FOREIGN KEY (section_id) REFERENCES class_sections(section_id)
);

INSERT INTO section_meetings (section_id, meeting_type, start_time, end_time, days_of_week, building_and_room)
    VALUES ('S1', 'Lecture', '10:00', '11:00', 'MWF', 'CSB 130');
INSERT INTO section_meetings (section_id, meeting_type, start_time, end_time, days_of_week, building_and_room)
    VALUES ('S2', 'Lecture', '11:00', '12:00', 'MWF', 'CSB 130');
INSERT INTO section_meetings (section_id, meeting_type, start_time, end_time, days_of_week, building_and_room)
    VALUES ('S3', 'Lecture', '13:00', '14:00', 'MWF', 'CSB 130');
INSERT INTO section_meetings (section_id, meeting_type, start_time, end_time, days_of_week, building_and_room)
    VALUES ('S4', 'Lecture', '14:00', '15:00', 'MWF', 'CSB 130');
INSERT INTO section_meetings (section_id, meeting_type, start_time, end_time, days_of_week, building_and_room)
    VALUES ('S5', 'Lecture', '11:00', '12:00', 'MWF', 'CSB 130');
INSERT INTO section_meetings (section_id, meeting_type, start_time, end_time, days_of_week, building_and_room)
    VALUES ('S6', 'Lecture', '09:00', '10:00', 'MWF', 'CSB 130');
INSERT INTO section_meetings (section_id, meeting_type, start_time, end_time, days_of_week, building_and_room)
    VALUES ('S7', 'Lecture', '08:00', '09:00', 'MWF', 'CSB 130');
INSERT INTO section_meetings (section_id, meeting_type, start_time, end_time, days_of_week, building_and_room)
    VALUES ('S8', 'Lecture', '10:00', '11:00', 'MWF', 'CSB 130');
INSERT INTO section_meetings (section_id, meeting_type, start_time, end_time, days_of_week, building_and_room)
    VALUES ('S9', 'Lecture', '11:00', '12:00', 'MWF', 'CSB 130');
INSERT INTO section_meetings (section_id, meeting_type, start_time, end_time, days_of_week, building_and_room)
    VALUES ('S10', 'Lecture', '12:00', '13:00', 'MWF', 'CSB 130');
INSERT INTO section_meetings (section_id, meeting_type, start_time, end_time, days_of_week, building_and_room)
    VALUES ('S11', 'Lecture', '10:00', '11:00', 'MWF', 'CSB 130');
INSERT INTO section_meetings (section_id, meeting_type, start_time, end_time, days_of_week, building_and_room)
    VALUES ('S12', 'Lecture', '13:00', '14:00', 'MWF', 'CSB 130');
INSERT INTO section_meetings (section_id, meeting_type, start_time, end_time, days_of_week, building_and_room)
    VALUES ('S13', 'Lecture', '11:00', '12:00', 'MWF', 'CSB 130');