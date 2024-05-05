CREATE TABLE attended_during (
    PID VARCHAR(255) NOT NULL,
    attend_start_date DATE NOT NULL,
    attend_end_date DATE NOT NULL,
    FOREIGN KEY (PID) REFERENCES students(PID),
    PRIMARY KEY (PID, attend_start_date, attend_end_date)
);

-- Valid PID and range
INSERT INTO attended_during (PID, attend_start_date, attend_end_date)
    VALUES ('A99', '2018-01-01', '2022-01-01');

-- Date range overlap for same student
INSERT INTO attended_during (PID, attend_start_date, attend_end_date)
    VALUES ('A99', '2019-01-01', '2020-01-01');

-- Date range goes in backwards order
INSERT INTO attended_during (PID, attend_start_date, attend_end_date)
    VALUES ('A99', '2020-01-01', '2019-01-01');

-- Different student, same date range
INSERT INTO attended_during (PID, attend_start_date, attend_end_date)
    VALUES ('A88', '2018-01-01', '2022-01-01');