CREATE TABLE enrollment (
    student_pid VARCHAR(255) NOT NULL,
    class_id int NOT NULL,
    section_id VARCHAR(255) NOT NULL,
    units int NOT NULL,
    waitlist_spot int NOT NULL DEFAULT 0,
    enrollment_id SERIAL PRIMARY KEY,
    FOREIGN KEY (student_pid) REFERENCES students(PID),
    FOREIGN KEY (section_id) REFERENCES class_sections(section_id),
    FOREIGN KEY (class_id) REFERENCES classes(class_id)
);

CREATE OR REPLACE FUNCTION check_enrollment_cap() 
RETURNS TRIGGER AS $$
DECLARE
    current_enrollment INT;
    cap INT;
BEGIN
    -- Obtain current number of enrollments for section
    SELECT COUNT(*) INTO current_enrollment
    FROM enrollment
    WHERE section_id = NEW.section_id;

    -- Obtain enrollment cap for section
    SELECT cs.enrollment_cap INTO cap 
    FROM class_sections cs
    WHERE cs.section_id = NEW.section_id;

    -- Check if new enrollment would exceed cap
    IF current_enrollment >= cap THEN
        RAISE EXCEPTION 'Enrollment cap exceeded for section %', NEW.section_id;
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trigger_check_enrollment_cap
BEFORE INSERT OR UPDATE ON enrollment
FOR EACH ROW
EXECUTE FUNCTION check_enrollment_cap();

INSERT INTO enrollment (student_pid, class_id, section_id, units) 
    VALUES ('1', 1, 'S1', 4);
INSERT INTO enrollment (student_pid, class_id, section_id, units) 
    VALUES ('2', 1, 'S1', 4);
INSERT INTO enrollment (student_pid, class_id, section_id, units) 
    VALUES ('2', 5, 'S5', 4);
INSERT INTO enrollment (student_pid, class_id, section_id, units) 
    VALUES ('3', 1, 'S1', 4);
INSERT INTO enrollment (student_pid, class_id, section_id, units) 
    VALUES ('4', 1, 'S1', 4);
INSERT INTO enrollment (student_pid, class_id, section_id, units) 
    VALUES ('5', 1, 'S1', 4);
INSERT INTO enrollment (student_pid, class_id, section_id, units) 
    VALUES ('6', 1, 'S1', 4);
INSERT INTO enrollment (student_pid, class_id, section_id, units) 
    VALUES ('7', 1, 'S1', 4);