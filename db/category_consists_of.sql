CREATE TABLE category_consists_of (
    category_name VARCHAR(255) NOT NULL,
    course_id int NOT NULL,
    id SERIAL PRIMARY KEY, 
    FOREIGN KEY (course_id) REFERENCES courses(course_id)
);

INSERT INTO category_consists_of (category_name, course_id)
    VALUES ('upper division', 1);
INSERT INTO category_consists_of (category_name, course_id)
    VALUES ('technical elective', 2);
INSERT INTO category_consists_of (category_name, course_id)
    VALUES ('lower division', 3);
INSERT INTO category_consists_of (category_name, course_id)
    VALUES ('upper division', 4);
INSERT INTO category_consists_of (category_name, course_id)
    VALUES ('technical elective', 4); 
INSERT INTO category_consists_of (category_name, course_id)
    VALUES ('technical elective', 5);
INSERT INTO category_consists_of (category_name, course_id)
    VALUES ('lower division', 6); 
INSERT INTO category_consists_of (category_name, course_id)
    VALUES ('lower division', 7); 
INSERT INTO category_consists_of (category_name, course_id)
    VALUES ('lower division', 8); 
INSERT INTO category_consists_of (category_name, course_id)
    VALUES ('lower division', 9); 
INSERT INTO category_consists_of (category_name, course_id)
    VALUES ('lower division', 10); 
INSERT INTO category_consists_of (category_name, course_id)
    VALUES ('lower division', 11); 
INSERT INTO category_consists_of (category_name, course_id)
    VALUES ('lower division', 12); 
