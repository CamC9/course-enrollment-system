CREATE TABLE probation_period (
    PID VARCHAR(255) NOT NULL,
    probation_id INT PRIMARY KEY,
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    reason VARCHAR(255) NOT NULL,
    FOREIGN KEY (PID) REFERENCES students(PID)
);

-- Valid PID
INSERT INTO probation_period (PID, probation_id, start_date, end_date, reason)
    VALUES ('A99', 1, '2018-01-01', '2022-01-01', 'Poor grades');

-- Date range goes in backwards order
INSERT INTO probation_period (PID, probation_id, start_date, end_date, reason)
    VALUES ('A99', 3, '2022-01-01', '2018-01-01', 'Misconduct');

-- Different student, same date range
INSERT INTO probation_period (PID, probation_id, start_date, end_date, reason)
    VALUES ('A88', 4, '2018-01-01', '2022-01-01', 'Misconduct');

-- Invalid date range overlap for same student
INSERT INTO probation_period (PID, probation_id, start_date, end_date, reason)
    VALUES ('A99', 5, '2019-01-01', '2020-01-01', 'Poor grades');