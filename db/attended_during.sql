CREATE TABLE attended_during (
    PID VARCHAR(255) NOT NULL,
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    id SERIAL PRIMARY KEY,
    FOREIGN KEY (PID) REFERENCES students(PID)
);

-- Valid PID and range
INSERT INTO attended_during (PID, start_date, end_date)
    VALUES ('A99', '2018-01-01', '2022-01-01');

-- Date range overlap for same student
INSERT INTO attended_during (PID, start_date, end_date)
    VALUES ('A99', '2019-01-01', '2020-01-01');

-- Date range goes in backwards order
INSERT INTO attended_during (PID, start_date, end_date)
    VALUES ('A99', '2020-01-01', '2019-01-01');

-- Different student, same date range
INSERT INTO attended_during (PID, start_date, end_date)
    VALUES ('A88', '2018-01-01', '2022-01-01');