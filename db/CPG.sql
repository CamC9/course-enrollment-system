DROP TABLE IF EXISTS cpg_table CASCADE;
DROP VIEW IF EXISTS CPG CASCADE;
DROP FUNCTION IF EXISTS update_cpg CASCADE;
DROP FUNCTION IF EXISTS delete_from_cpg CASCADE;
DROP TRIGGER IF EXISTS trigger_update_cpg ON past_enrollment CASCADE;
DROP TRIGGER IF EXISTS trigger_delete_cpg ON past_enrollment CASCADE;

CREATE TABLE cpg_table (
    course_id INT,
    instructor VARCHAR(255),
    grade VARCHAR(255),
    grade_count INT
);

CREATE OR REPLACE VIEW CPG AS
SELECT 
    course_id, 
    instructor, 
    grade,
    grade_count
FROM cpg_table; 

-- Trigger Function
CREATE OR REPLACE FUNCTION update_cpg() 
RETURNS TRIGGER AS $$
DECLARE
    retrieved_course_id INT;
    retrieved_instructor VARCHAR(255);
BEGIN
    SELECT cls.course_id, cs.instructor INTO retrieved_course_id, retrieved_instructor
    FROM classes cls
    JOIN class_sections cs ON cls.class_id = cs.class_id
    WHERE cls.class_id = NEW.class_id;
    IF NEW.grade != 'IN' THEN
        IF EXISTS (
            SELECT 1 
            FROM cpg_table 
            WHERE course_id = retrieved_course_id
            AND instructor = retrieved_instructor
            AND grade = NEW.grade
        ) THEN
            UPDATE cpg_table 
            SET grade_count = grade_count + 1
            WHERE course_id = retrieved_course_id 
            AND instructor = retrieved_instructor
            AND grade = NEW.grade;
        ELSE
            INSERT INTO cpg_table (course_id, instructor, grade, grade_count)
            VALUES (retrieved_course_id, retrieved_instructor, NEW.grade, 1);
        END IF;
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Trigger for insert or update on past_enrollment 
CREATE TRIGGER trigger_update_cpg
AFTER INSERT OR UPDATE ON past_enrollment
FOR EACH ROW
EXECUTE FUNCTION update_cpg();

-- Trigger Function for DELETE on past_enrollment
CREATE OR REPLACE FUNCTION delete_from_cpg() 
RETURNS TRIGGER AS $$
DECLARE
    retrieved_course_id INT;
    retrieved_instructor VARCHAR(255);
BEGIN
    SELECT cls.course_id, cs.instructor INTO retrieved_course_id, retrieved_instructor
    FROM classes cls
    JOIN class_sections cs ON cls.class_id = cs.class_id
    WHERE cls.class_id = OLD.class_id;
    IF OLD.grade != 'IN' THEN
        IF EXISTS (
            SELECT 1 
            FROM cpg_table 
            WHERE course_id = retrieved_course_id 
            AND instructor = retrieved_instructor 
            AND grade = OLD.grade
            AND grade_count > 1
        ) THEN
            UPDATE cpg_table
            SET grade_count = grade_count - 1
            WHERE course_id = retrieved_course_id 
            AND instructor = retrieved_instructor 
            AND grade = OLD.grade;
        ELSE
            DELETE FROM cpg_table
            WHERE course_id = retrieved_course_id 
            AND instructor = retrieved_instructor 
            AND grade = OLD.grade;
        END IF;
    END IF;
    RETURN OLD;
END;
$$ LANGUAGE plpgsql;

-- Trigger for DELETE on past_enrollment
CREATE TRIGGER trigger_delete_cpg
AFTER DELETE ON past_enrollment
FOR EACH ROW
EXECUTE FUNCTION delete_from_cpg();
