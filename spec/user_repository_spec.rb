require '../../chitter-challenge/lib/user.rb' 
require '../../chitter-challenge/lib/user_repository.rb'
require '../spec/spec_helper.rb' 
# require '../lib/database_connection.rb'

def reset_tweets_table
    seed_sql = File.read('../databases/tweets_seeds.sql')
    connection = PG.connect({ host: '127.0.0.1', dbname: 'twitter_test' })
    connection.exec(seed_sql)
end

def reset_users_table
    seed_sql = File.read('../databases/tweets_seeds.sql')
    connection = PG.connect({ host: '127.0.0.1', dbname: 'twitter_test' })
    connection.exec(seed_sql)
end

describe UserRepository do
    before(:each) do
        reset_tweets_table
        reset_users_table  
    end

    context "Given entries of users" do
       it "list all users" do
            user = UserRepository.new
            all_users = user.all

            expect(all_users.count).to eq(2)
        end
    end

    context "searching for a user by id" do
        it "returns the specific user information" do
            user = UserRepository.new
           
            specific_user = user.find(2)
           
            expect(specific_user["id"]).to eq("2")
            expect(specific_user["name"]).to eq("name2")
            expect(specific_user["username"]).to eq("name234")
            expect(specific_user["email"]).to eq("name2@email.com")
            expect(specific_user["password"]).to eq("password2")
        end
    end

    context "searching users by specific email" do
        it "returns specific user detail" do
            user = UserRepository.new
            specific_user = user.find_by_email("name2@email.com")
          
            expect(specific_user["id"]).to eq("2")
        end
    end

    context "Given new user details" do
        it " creates a user and stores it in the database" do
            repo = UserRepository.new
            user = User.new
            
            user.name = "hibaq"
            user.username = "hibaq123"
            user.email = "hibaq@email.com"
            user.password = "password3"
            repo.create(user)
        end

    end

    context "Given user details that match database records" do
       it "login success" do
            repo = UserRepository.new
            user = User.new
            
            user.name = "hibaq"
            user.username = "hibaq123"
            user.email = "hibaq@email.com"
            user.password = "password3"
            repo.create(user)
            
            account = repo.sign_in("hibaq@email.com", "password3")

            expect(account["email"]).to eq(user.email)

       end

    end




end
