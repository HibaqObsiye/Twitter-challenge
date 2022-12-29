require_relative './user.rb'
require_relative './user_repository'

class UserParams
    def initialize(name, username, email, password)
        @name = name
        @username = username
        @email = email
        @password = password
    end

    def invalid_email?
        (@email !~ /\A([\w+\-]\.?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i ) || duplicate_email?
    end

    def name_contains_incorrect_characters?
        @name.gsub!(/[^0-9A-Za-z -.]/, '') == @name
    end

    def username_contains_incorrect_characters?
        @username.gsub!(/[^0-9A-Za-z -.]/, '') == @username
    end

    def password_contains_incorrect_characters?
        @password.gsub!(/[^A-Za-z0-9]/,'') == @password
    end

   def weak_password?
        @password.length < 8 || @password.count("0-9") == 0
   end

   def duplicate_username?
        repo = UserRepository.new
        all_users = repo.all
        duplicate_username = true

        all_users.each do |user|
        if  @username.downcase == user.username.downcase
                duplicate_username = true
        end
        end
        return duplicate_username
   end

   def duplicate_email?
    repo = UserRepository.new
    all_email = repo.all
    duplicate_email = true

    all_email.each do |email|
        if @email == email
            duplicate_email =  true
        end
    end
        return duplicate_email
   end

   def invalid_params?
    invalid_email? || name_contains_incorrect_characters? || username_contains_incorrect_characters? || password_contains_incorrect_characters? || weak_password? || duplicate_username? || duplicate_email?
   end

end