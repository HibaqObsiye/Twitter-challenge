require './lib/user.rb' 
require'./lib/database_connection.rb'  
require 'bcrypt'

class UserRepository

    def all
        query = "SELECT id, name, username, email, password FROM users"
        params = []

        result_set = DatabaseConnection.exec_params(query, params)
        result_set
        users = []
        user = User.new
        result_set.each do |record|
            user.id = record["id"]
            user.name = record['username']
            user.username = record["email"]
            user.password = record["password"]

           users << user
        end
        users
    end

   def find(id)
    query = "SELECT id, name, username, email, password FROM users WHERE id = $1"
    params =[id]

    result_set = DatabaseConnection.exec_params(query, params)
    result_set[0]
   end

   def find_by_email(email)
        query = "SELECT * FROM users WHERE email = $1"
        params = [email]

        result_set = DatabaseConnection.exec_params(query, params)
        result_set[0]
   end

   def create(user)
        encrypted_password = BCrypt::Password.create(user.password)
        query = "INSERT into users (id, name, username, email, password) VALUES ($1, $2, $3, $4 , $5) "

        params = [user.id, user.name, user.username, user.email, encrypted_password]

        result_set = DatabaseConnection.exec_params(query, params)

        return ''
   end

   def sign_in(email, submitted_password)
        repo = UserRepository.new
        user = repo.find_by_email(email)

        return nil if user.nil?

        if BCrypt::Password.new(user["password"]) == submitted_password 
            return user
        else
            return false
        end
   end
end