## Step 0: User stories or specification
 As a user
So that I can use twitter
I want to be able to sign-up

As a user
So that I can know my twitter sign-up was successful
I want to be able to login.

As a user
So that I can join in on the fun
I want to see the tweets of other people.

As a user
So that I can share my voice
I want to be able to make a tweet.

As a user
So that I can keep track of tweets
I want to be able see them in reverse chronological order.

As a user
So that I can keep track of tweets
I want to be able see the time it was posted.

## Step 2: Planning pages

## Step 3: Planning routes

## Requests:
GET /
No parameters

## Response (200 OK)
HTML view with homepage
# Page: see full entry 

## Requests:
GET /sign-up
No parameters

## Response (200 OK)
HTML view with sign-up page 
# Page: sign-up form

## Requests:
POST /sign-up
 with parameters:
 name = james
 email = james@email.com
 password = kdmgfxcivbi

 ## Response (200 OK)
HTML view with confirmation message of successful sign-up

## Requests:
GET /login
No parameters

## Requests:
POST /login
 with parameters:
 name = james
 email = james@email.com
 password = kdmgfxcivbi

  ## Response (200 OK)
HTML view with confirmation message of successful login


## Response (200 OK)
HTML view with login page
# Page: login form

## Requests:
GET /tweets
No parameters

## Response (200 OK)
HTML view with list of tweets
# Page: see full list of tweets

## Request:
GET /tweets/:id
With path parameter :id

## Response (200 OK)
HTML view with details of a single tweet
# Page: add a new entry

## Request:
GET /tweets/add
no parameters

## Response (200 OK)
HTML view with form to submit new entry (to POST /tweets)
# Page: new tweet added

## Request:
POST /tweets
With parameters:
  title="What a great Sunday"
  content="..."

## Response (200 OK)
HTML view with confirmation message

## Step 4 Designing table schema (two table)

Nouns: Tweets and user

| Record                | Properties          |
| --------------------- | ------------------  |
|   tweets              | message, time_stamp |
|    user               | email,password, name|
|                       |   and username      |    

1) Name of the first table: Tweets
   column names =  'message', 'time stamp'

2) Name of the second table: 'Users'
    column names: 'email', 'password', 'name', 'username'

## Step 5 Decide on The Tables Relationship

1) Can one [tweet] have many [users]? (No)
2) Can one [User] have many [tweets]? (Yes)
   
Therefore,
--> A user has many tweets
--> A tweet belongs to a user

--> So the foreign key is on the tweet table

## Step 6 Write the SQL

CREATE TABLE users (
  id SERIAL PRIMARY KEY,
  name: text,
  email: varchar,
  password: char,
  username: text
);

CREATE TABLE tweets (
  id SERIAL PRIMARY KEY,
  message: text,
  time_stamp: timestamp,
  The foreign key name is always {user}_id
    user_id int,
  constraint fk_user foreign key(user_id)
    references users(id)
    on delete cascade
);

## Step 6 create the tables

#