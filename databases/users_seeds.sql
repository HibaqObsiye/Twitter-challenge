TRUNCATE TABLE users RESTART IDENTITY CASCADE;


INSERT INTO users("name", "email", "password", "username") VALUES
('name1', 'name@email.com', 'password1', 'name123'),
('name2', 'name2@email.com', 'password2', 'name234');
