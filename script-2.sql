CREATE DATABASE company;

CREATE TABLE users (
	id SERIAL PRIMARY KEY,
  	name_user VARCHAR(80),
  	email VARCHAR(100)
)

CREATE TABLE audit (
    id SERIAL PRIMARY KEY,
    user_id INT,
    actions VARCHAR(100),
    data TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id)
);

CREATE OR REPLACE FUNCTION register_insertion()
RETURNS TRIGGER AS $$
BEGIN
    INSERT INTO audit (user_id, actions)
    VALUES (NEW.id, 'INSERT');
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;


CREATE TRIGGER after_insert_user
AFTER INSERT ON users
FOR EACH ROW
EXECUTE FUNCTION register_insertion();

INSERT INTO users (name_user, email)
VALUES ('Esdras Marcelino Da Silva', 'ems.silva@ibest.com');

SELECT * FROM users

SELECT * from audit