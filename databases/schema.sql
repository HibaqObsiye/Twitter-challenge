DROP TABLE users, tweets;

CREATE TABLE users (
  id SERIAL PRIMARY KEY,
  name text,
  username text,
  email text,
  password text
);

CREATE TABLE tweets (
    id SERIAL PRIMARY KEY,
    message text,
    time_stamp timestamp,
    user_id int,
    constraint fk_user foreign key(user_id)
    references users(id)
);