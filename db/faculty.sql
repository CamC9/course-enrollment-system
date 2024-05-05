CREATE TABLE faculty (
    name VARCHAR(255) PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    department VARCHAR(255) NOT NULL
);

-- Regular entry
INSERT INTO faculty (name, title, department) 
    VALUES ('John Doe', 'Professor', 'Computer Science');

-- Valid entry
INSERT INTO faculty (name, title, department) 
    VALUES ('Jane Doe', 'Professor', 'Cognitive Science');

-- Valid entry
INSERT INTO faculty (name, title, department) 
    VALUES ('Jin Doe', 'Professor', 'Computer Science');

-- Valid entry
INSERT INTO faculty (name, title, department) 
    VALUES ('Jackson Doe', 'Professor', 'Computer Science');