CREATE TABLE faculty (
    Name VARCHAR(255) PRIMARY KEY,
    Title VARCHAR(255) NOT NULL,
    Department VARCHAR(255) NOT NULL, 
    SSN INT NOT NULL
);

INSERT INTO faculty (NAME, Title, Department, SSN) 
    VALUES ('John Doe', 'Professor', 'Computer Science', '111223333');