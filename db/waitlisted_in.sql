CREATE TABLE waitlisted_in (
    PID VARCHAR(255) NOT NULL,
    section_id int NOT NULL,
    date_and_time TIMESTAMP NOT NULL,
    waitlist_position int NOT NULL,
    waitlist_id int PRIMARY KEY,
    FOREIGN KEY (PID) REFERENCES students(PID),
    FOREIGN KEY (section_id) REFERENCES class_sections(section_id)
);

-- Valid PID
INSERT INTO waitlisted_in (PID, section_id, date_and_time, waitlist_position, waitlist_id)
    VALUES ('A99', 1, '2018-01-01 00:00:00', 1, 1);

-- Duplicate position for different student
INSERT INTO waitlisted_in (PID, section_id, date_and_time, waitlist_position, waitlist_id)
    VALUES ('A88', 1, '2018-01-01 00:00:00', 1, 2);

-- Second waitlisted class for student
INSERT INTO waitlisted_in (PID, section_id, date_and_time, waitlist_position, waitlist_id)
    VALUES ('A99', 2, '2018-01-01 00:00:00', 1, 3);