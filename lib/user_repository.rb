require '../lib/user.rb'
require'../lib/database_connection.rb'

class UserRepository

    def all
        query = "SELECT id, name, username, email, password FROM users"
        params = []

        result_set = DatabaseConnection.exec_params(query, params)
        result_set[0]
        users = []
        user = User.new
        result_set.each do |record|
            user.id = record["id"]
            user.name = record['username']
            user.username = record["email"]
            user.password = record["password"]

           users << user
        end
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
    query = "INSERT users (id, name, username, email, password) VALUES ($1, $2, $3, $4, $5) "
    params = [id, name, username, email, password]

    result_set = DatabaseConnection.exec_params(query, params)
   end

#    def login(user)



  




end