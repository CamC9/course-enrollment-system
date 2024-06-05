CREATE TABLE faculty (
    name VARCHAR(255) PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    department VARCHAR(255) NOT NULL
);

INSERT INTO faculty (name, title, department)
    VALUES ('Dr. Alan Turing', 'Professor', 'Computer Science');
INSERT INTO faculty (name, title, department)
    VALUES ('Dr. Ada Lovelace', 'Professor', 'Computer Science');
INSERT INTO faculty (name, title, department)
    VALUES ('Dr. Andrew Ng', 'Professor', 'Computer Science');
INSERT INTO faculty (name, title, department)
    VALUES ('Dr. Geoffrey Hinton', 'Professor', 'Computer Science');
INSERT INTO faculty (name, title, department)
    VALUES ('Dr. Carl Gauss', 'Professor', 'Mathematics');
INSERT INTO faculty (name, title, department)
    VALUES ('Dr. Albert Einstein', 'Professor', 'Physics');
INSERT INTO faculty (name, title, department)
    VALUES ('Dr. James Watson', 'Professor', 'Biology');
INSERT INTO faculty (name, title, department)
    VALUES ('Dr. Marie Curie', 'Professor', 'Chemistry');
INSERT INTO faculty (name, title, department)
    VALUES ('Dr. John Tukey', 'Professor', 'Statistics');
INSERT INTO faculty (name, title, department)
    VALUES ('Dr. Ian Goodfellow', 'Professor', 'Computer Science');
INSERT INTO faculty (name, title, department)
    VALUES ('Dr. Alin D', 'Professor', 'Computer Science');