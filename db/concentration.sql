CREATE TABLE concentration (
    degree_name VARCHAR(255) NOT NULL,
    concentration_name VARCHAR(255) PRIMARY KEY,
    FOREIGN KEY (degree_name) REFERENCES degrees(degree_name)
);

-- Valid category_name 
INSERT INTO concentration (degree_name, concentration_name)
    VALUES ('MSC IN CS', 'Database');

-- Second category_name
INSERT INTO concentration (degree_name, concentration_name)
    VALUES ('MSC IN CS', 'Machine Learning');

-- COGS Concentrations
INSERT INTO concentration (degree_name, concentration_name)
    VALUES ('MSC IN COGS', 'Cognitive Neuroscience');

-- MATH Concentrations
INSERT INTO concentration (degree_name, concentration_name)
    VALUES ('MSC IN MATH', 'Pure Mathematics');