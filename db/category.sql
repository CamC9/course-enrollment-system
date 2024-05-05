CREATE TABLE category (
    category_name VARCHAR(255) PRIMARY KEY,
    min_units INT NOT NULL,
    min_gpa DECIMAL(3, 2) DEFAULT 0.00
);

-- Valid category_name
INSERT INTO category (category_name, min_units, min_gpa)
    VALUES ('Core Courses', 72, 3.00);

-- Second category_name
INSERT INTO category (category_name, min_units, min_gpa)
    VALUES ('Electives', 12, 3.00);