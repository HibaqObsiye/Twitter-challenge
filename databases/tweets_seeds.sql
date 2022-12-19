TRUNCATE TABLE users RESTART IDENTITY CASCADE;
TRUNCATE TABLE tweets RESTART IDENTITY CASCADE;

INSERT INTO users("name", "email", "password", "username") VALUES
('name1', 'name@email.com', 'password1', 'name123'),
('name2', 'name2@email.com', 'password2', 'name234');

INSERT INTO tweets("message", "time_stamp", "user_id") VALUES
('hello world', '2022-12-17 21:06:10',1),
('welcome back', '2022-12-16 03:14:07',2);