DROP TABLE IF EXISTS cpqg_table CASCADE;
DROP VIEW IF EXISTS CPQG CASCADE;
DROP FUNCTION IF EXISTS update_cpqg CASCADE;
DROP FUNCTION IF EXISTS delete_from_cpqg CASCADE;
DROP TRIGGER IF EXISTS trigger_update_cpqg ON past_enrollment CASCADE;
DROP TRIGGER IF EXISTS trigger_delete_from_cpqg ON past_enrollment CASCADE;

CREATE TABLE cpqg_table (
    course_id INT,
    instructor VARCHAR(255),
    quarter VARCHAR(255),
    year INT,
    grade VARCHAR(255),
    grade_count INT
);

CREATE OR REPLACE VIEW CPQG AS
SELECT 
    course_id, 
    instructor, 
    quarter, 
    year,
    grade,
    grade_count
FROM cpqg_table; 

-- Trigger Function for INSERT or UPDATE on past_enrollment
CREATE OR REPLACE FUNCTION update_cpqg() 
RETURNS TRIGGER AS $$
DECLARE
    retrieved_course_id INT;
    retrieved_instructor VARCHAR(255);
    retrieved_quarter VARCHAR(255);
    retrieved_year INT;
BEGIN
    SELECT cls.course_id, cs.instructor, cls.quarter, cls.year INTO retrieved_course_id, retrieved_instructor, retrieved_quarter, retrieved_year
    FROM classes cls
    JOIN class_sections cs ON cls.class_id = cs.class_id
    WHERE cls.class_id = NEW.class_id;

    IF EXISTS (
        SELECT 1 
        FROM cpqg_table 
        WHERE course_id = retrieved_course_id 
        AND instructor = retrieved_instructor 
        AND quarter = retrieved_quarter
        AND year = retrieved_year 
        AND grade = NEW.grade
    ) THEN
        UPDATE cpqg_table
        SET grade_count = grade_count + 1
        WHERE course_id = retrieved_course_id 
        AND instructor = retrieved_instructor 
        AND quarter = retrieved_quarter 
        AND year = retrieved_year 
        AND grade = NEW.grade;
    ELSE
        INSERT INTO cpqg_table (course_id, instructor, quarter, year, grade, grade_count)
        VALUES (retrieved_course_id, retrieved_instructor, retrieved_quarter, retrieved_year, NEW.grade, 1);
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Trigger for insert or update on past_enrollment 
CREATE TRIGGER trigger_update_cpqg
AFTER INSERT OR UPDATE ON past_enrollment
FOR EACH ROW
EXECUTE FUNCTION update_cpqg();

-- Trigger Function for DELETE on past_enrollment
CREATE OR REPLACE FUNCTION delete_from_cpqg() 
RETURNS TRIGGER AS $$
DECLARE
    retrieved_course_id INT;
    retrieved_instructor VARCHAR(255);
    retrieved_quarter VARCHAR(255);
    retrieved_year INT;
BEGIN
    SELECT cls.course_id, cs.instructor, cls.quarter, cls.year INTO retrieved_course_id, retrieved_instructor, retrieved_quarter, retrieved_year
    FROM classes cls
    JOIN class_sections cs ON cls.class_id = cs.class_id
    WHERE cls.class_id = OLD.class_id;

    IF EXISTS (
        SELECT 1 
        FROM cpqg_table 
        WHERE course_id = retrieved_course_id 
        AND instructor = retrieved_instructor 
        AND quarter = retrieved_quarter
        AND year = retrieved_year 
        AND grade = OLD.grade
        AND grade_count > 1
    ) THEN
        UPDATE cpqg_table
        SET grade_count = grade_count - 1
        WHERE course_id = retrieved_course_id 
        AND instructor = retrieved_instructor 
        AND quarter = retrieved_quarter 
        AND year = retrieved_year 
        AND grade = OLD.grade;
    ELSE
        DELETE FROM cpqg_table
        WHERE course_id = retrieved_course_id 
        AND instructor = retrieved_instructor 
        AND quarter = retrieved_quarter 
        AND year = retrieved_year 
        AND grade = OLD.grade;
    END IF;
    RETURN OLD;
END;
$$ LANGUAGE plpgsql;

-- Trigger for delete on past_enrollment 
CREATE TRIGGER trigger_delete_from_cpqg
AFTER DELETE ON past_enrollment
FOR EACH ROW
EXECUTE FUNCTION delete_from_cpqg();