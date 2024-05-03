CREATE TABLE faculty (
    name VARCHAR(255) PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    department VARCHAR(255) NOT NULL
);

-- Regular entry
INSERT INTO faculty (name, title, department) 
    VALUES ('John Doe', 'Professor', 'Computer Science');

-- Duplicate name
INSERT INTO faculty (name, title, department) 
    VALUES ('John Doe', 'Lecturer', 'Cognitive Science');

