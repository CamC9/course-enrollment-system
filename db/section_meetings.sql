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


CREATE OR REPLACE FUNCTION check_meeting_overlap() 
RETURNS TRIGGER AS $$
DECLARE
    overlap BOOLEAN;
BEGIN
    -- Check for overlapping meetings from same section
    overlap := EXISTS (
        SELECT 1 
        FROM section_meetings 
        WHERE section_id = NEW.section_id
        AND (
            (NEW.start_time < end_time AND NEW.end_time > start_time)
        )
        AND (
            (
                position('M' in NEW.days_of_week) > 0 AND position('M' in days_of_week) > 0 OR
                position('Tu' in NEW.days_of_week) > 0 AND position('Tu' in days_of_week) > 0 OR
                position('W' in NEW.days_of_week) > 0 AND position('W' in days_of_week) > 0 OR
                position('Th' in NEW.days_of_week) > 0 AND position('Th' in days_of_week) > 0 OR
                position('F' in NEW.days_of_week) > 0 AND position('F' in days_of_week) > 0 OR
                position('S' in NEW.days_of_week) > 0 AND position('S' in days_of_week) > 0
            )
        )
    );

    IF overlap THEN
        RAISE EXCEPTION 'Meeting time overlaps with an existing meeting for the same SectionID on at least one day';
    END IF;

    -- Check for overlapping meetings taught by the same professor in different sections
    overlap := EXISTS (
        SELECT 1 
        FROM section_meetings sm
        JOIN class_sections cs ON sm.section_id = cs.section_id
        WHERE cs.instructor = (SELECT instructor FROM class_sections WHERE section_id = NEW.section_id)
        AND sm.section_id != NEW.section_id
        AND (
            (NEW.start_time < sm.end_time AND NEW.end_time > sm.start_time)
        )
        AND (
            (
                position('M' in NEW.days_of_week) > 0 AND position('M' in sm.days_of_week) > 0 OR
                position('Tu' in NEW.days_of_week) > 0 AND position('Tu' in sm.days_of_week) > 0 OR
                position('W' in NEW.days_of_week) > 0 AND position('W' in sm.days_of_week) > 0 OR
                position('Th' in NEW.days_of_week) > 0 AND position('Th' in sm.days_of_week) > 0 OR
                position('F' in NEW.days_of_week) > 0 AND position('F' in sm.days_of_week) > 0 OR
                position('S' in NEW.days_of_week) > 0 AND position('S' in sm.days_of_week) > 0
            )
        )
    );

    IF overlap THEN
        RAISE EXCEPTION 'Professor holds another meeting in another section at the same time on the same day';
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trigger_check_meeting_overlap
BEFORE INSERT OR UPDATE ON section_meetings
FOR EACH ROW
EXECUTE FUNCTION check_meeting_overlap();


INSERT INTO section_meetings (section_id, meeting_type, start_time, end_time, days_of_week, building_and_room)
    VALUES ('S1', 'Lecture', '10:00', '10:59', 'MWF', 'CSB 130');
INSERT INTO section_meetings (section_id, meeting_type, start_time, end_time, days_of_week, building_and_room)
    VALUES ('S2', 'Lecture', '11:00', '11:59', 'MWF', 'CSB 130');
INSERT INTO section_meetings (section_id, meeting_type, start_time, end_time, days_of_week, building_and_room)
    VALUES ('S3', 'Lecture', '13:00', '13:59', 'MWF', 'CSB 130');
INSERT INTO section_meetings (section_id, meeting_type, start_time, end_time, days_of_week, building_and_room)
    VALUES ('S4', 'Lecture', '14:00', '14:59', 'MWF', 'CSB 130');
INSERT INTO section_meetings (section_id, meeting_type, start_time, end_time, days_of_week, building_and_room)
    VALUES ('S5', 'Lecture', '11:00', '11:59', 'MWF', 'CSB 130');
INSERT INTO section_meetings (section_id, meeting_type, start_time, end_time, days_of_week, building_and_room)
    VALUES ('S6', 'Lecture', '09:00', '9:59', 'MWF', 'CSB 130');
INSERT INTO section_meetings (section_id, meeting_type, start_time, end_time, days_of_week, building_and_room)
    VALUES ('S7', 'Lecture', '08:00', '08:59', 'MWF', 'CSB 130');
INSERT INTO section_meetings (section_id, meeting_type, start_time, end_time, days_of_week, building_and_room)
    VALUES ('S8', 'Lecture', '10:00', '10:59', 'MWF', 'CSB 130');
INSERT INTO section_meetings (section_id, meeting_type, start_time, end_time, days_of_week, building_and_room)
    VALUES ('S9', 'Lecture', '11:00', '11:59', 'MWF', 'CSB 130');
INSERT INTO section_meetings (section_id, meeting_type, start_time, end_time, days_of_week, building_and_room)
    VALUES ('S10', 'Lecture', '12:00', '12:59', 'MWF', 'CSB 130');
INSERT INTO section_meetings (section_id, meeting_type, start_time, end_time, days_of_week, building_and_room)
    VALUES ('S11', 'Lecture', '10:00', '10:59', 'MWF', 'CSB 130');
INSERT INTO section_meetings (section_id, meeting_type, start_time, end_time, days_of_week, building_and_room)
    VALUES ('S12', 'Lecture', '13:00', '13:59', 'MWF', 'CSB 130');
INSERT INTO section_meetings (section_id, meeting_type, start_time, end_time, days_of_week, building_and_room)
    VALUES ('S13', 'Lecture', '11:00', '11:59', 'MWF', 'CSB 130');