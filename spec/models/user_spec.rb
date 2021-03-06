require 'spec_helper'

describe User do
    it "has the username set correctly" do
        user = User.new username:"Pekka"

        user.username.should == "Pekka"
    end

    it "is not saved without a password" do
        user = User.create username:"Pekka"

        expect(user.valid?).to be(false)
        expect(User.count).to eq(0)
    end

    it "is not saved with invalid password" do
        user = User.create username:"Pekka", password:"Sec", password_confirmation:"Sec"

        expect(user.valid?).to be(false)
        expect(User.count).to eq(0)
    end

    describe "with a proper password" do
        let(:user) { FactoryGirl.create(:user) }

        it "is saved" do
            
            expect(user.valid?).to be(true)
            expect(User.count).to eq(1)
        end

        it "and with two ratings, has the correct average rating" do
            user.ratings << FactoryGirl.create(:rating)
            user.ratings << FactoryGirl.create(:rating2)

            expect(user.ratings.count).to eq(2)
            expect(user.average_rating).to eq(15.0)
        end
    end

    describe "favorite beer" do
        let(:user) { FactoryGirl.create(:user) }
    
        it "has method for determining the favorite_beer" do
       
            user.should respond_to :favorite_beer
        end

        it "without ratings does not hava a favorite beer" do

            expect(user.favorite_beer).to eq(nil)
        end

        it "is the only rated if only one rating" do
            beer = FactoryGirl.create(:beer)
            rating = FactoryGirl.create(:rating, beer:beer, user:user)

            expect(user.favorite_beer).to eq(beer)
        end

        it "is the one with highest rating if several rated" do
            create_beers_with_ratings(10, 20, 15, 7, 9, user)
            best = create_beer_with_style(25, user, nil, nil)
        

            expect(user.favorite_beer).to eq(best)
        end
    end

    describe "favorite style" do
        let(:user) { FactoryGirl.create(:user) }
        let(:style) {FactoryGirl.create :style, name: "Bock"}
    
        it "has method for determining the favorite_style" do
       
            user.should respond_to :favorite_style
        end

        it "without ratings does not have a favorite style" do

            expect(user.ratings.count).to eq(0)
            expect(user.favorite_style).to eq(nil)
        end

        it "is the only style if only one rating" do
            favorite = create_beer_with_style(26, user, style, nil)

            expect(user.ratings.count).to eq(1)
            expect(user.favorite_style).to eq(favorite.style)
        end

        it "is the one rated highest if several ratings" do
            favorite = create_beer_with_style(26, user, style, nil)
            create_beers_with_ratings(10, 20, 15, user)
            
            expect(user.ratings.count).to eq(4)
            expect(user.favorite_style).to eq(favorite.style)    
        end

    end

    describe "favorite brewery" do
        let(:user) { FactoryGirl.create(:user) }
        let(:style) {FactoryGirl.create :style, name: "Bock"}

        it "has method for determining the favorite_brewery" do
            BeerClub
            BeerClubsController
            user.should respond_to :favorite_brewery
        end
        it "without ratings does not have a favorite brewery" do

            expect(user.ratings.count).to eq(0)
            expect(user.favorite_brewery).to eq(nil)
        end

        it "is the only brewery if only one rating" do
            favorite = create_beer_with_style(26, user, style, "Paulaner")

            expect(user.ratings.count).to eq(1)
            expect(user.favorite_brewery).to eq(favorite.brewery)
        end

        it "is the one rated highest if several ratings" do
            favorite = create_beer_with_style(26, user, style, "Bryggeri")
            create_beers_with_ratings(7, 5, 15, 8, user)
            
            expect(user.ratings.count).to eq(5)
            expect(user.favorite_brewery).to eq(favorite.brewery)     
        end

    end


    def create_beer_with_style(score, user, style, brewery)
        if style.nil?
            style = FactoryGirl.create :style
        end
        unless brewery.nil?
            brewery = FactoryGirl.create(:brewery, name:brewery)
        end
        beer = FactoryGirl.create(:beer, style:style, brewery:brewery)
        rating1 = FactoryGirl.create(:rating, score:score, beer:beer, user:user)
        beer
    end

    def create_beers_with_ratings(*scores, user)
        scores.each do |score|
            create_beer_with_style(score, user, nil, nil)
        end
    end
   
end
