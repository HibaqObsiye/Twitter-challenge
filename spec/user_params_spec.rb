require 'user_repository.rb'
require 'user_params.rb'
require 'user.rb'

describe UserParams do

    describe '#invalid_email?' do
        context "given a valid email" do
            it "returns false" do
                user_params = UserParams.new("name","name1","name@email.com", "name1234!")
                expect(user_params.invalid_email?).to eq(false)
            end
        end

        context "Given an email that doesn't include an @" do
            it "returns true" do
                user_params = UserParams.new("name","name1","nameemail.com", "name1234!")
                expect(user_params.invalid_email?).to eq(true)
            end
        end

        it "returns true if letters not included" do
            user_params = UserParams.new("name","name1","@.", "name1234!")
            expect(user_params.invalid_email?).to eq(true)
        end

        # context "Given an email that already exists" do
        #     it "returns true" do
        #         user_params = UserParams.new("name","name1","name1@gmail.com", "name1234!")
        #         user_params1 = UserParams.new("name","name1","name1@gmail.com", "name1234!")
        #         expect(user_params1.invalid_email?).to eq(true)
        #     end
        # end

    end

    describe '#invalid params' do

        it "Given a name that contains correct characters, it returns false" do
            user_params = UserParams.new("name","name1","name@email.com", "name1234!")
                expect(user_params.invalid_params?).to eq(false)
        end

        it "Given a username that contains correct characters, it returns false" do
            user_params = UserParams.new("name","name1","name@email.com", "name1234!")
                expect(user_params.invalid_params?).to eq(false)
        end

        context "Given name that contains incorrect characters" do
            it "returns true" do
                user_params = UserParams.new("na@e","name1","name@email.com", "name1234!")
                expect(user_params.invalid_params?).to eq(true)
            end
        end

        context "Given a username that contains incorrect characters" do
            it "returns true" do
                user_params = UserParams.new("name","na@e1","name@email.com", "name1234!")
                expect(user_params.invalid_params?).to eq(true)
            end
        end
    end


end