require 'spec_helper'
include OwnTestHelper

describe "Rating" do
  let!(:brewery) { FactoryGirl.create :brewery, name:"Koff" }
  let!(:brewery2) { FactoryGirl.create :brewery, name:"Puff" }
  let!(:beer1) { FactoryGirl.create :beer, name:"iso 3", brewery:brewery }
  let!(:beer2) { FactoryGirl.create :beer, name:"Karhu", brewery:brewery }
  let!(:beer3) { FactoryGirl.create :beer, name:"Brown", style:"Ale", brewery:brewery2 }
  let!(:user) { FactoryGirl.create :user }
  let!(:user2) { FactoryGirl.create :user, username:"Pirkka", password:"Sala1", password_confirmation:"Sala1"}

  before :each do
    sign_in(username:"Pekka", password:"Foobar1")
  end

  it "user has made none, the amount of ratings is 0" do
    
    expect(page).to have_content "has not yet given any ratings"
    expect(user.ratings.count).to eq(0)
  end

  it "when given, is registered to the beer and user who is signed in" do
    visit new_rating_path
    select('iso 3', from:'rating[beer_id]')
    fill_in('rating[score]', with:'15')

    expect{
      click_button "Create Rating"
    }.to change{Rating.count}.from(0).to(1)

    expect(user.ratings.count).to eq(1)
    expect(beer1.ratings.count).to eq(1)
    expect(beer1.average_rating).to eq(15.0)
  end

  it "when user has made several, the amount is shown correctly" do
    create_ratings_for_beer(3,4,6,beer1)

    visit new_rating_path
    select('Karhu', from:'rating[beer_id]')
    fill_in('rating[score]', with:'7')

    expect{
      click_button "Create Rating"
    }.to change{Rating.count}.from(3).to(4)

    expect(page).to have_content "has made 4 ratings"

  end

  it "when absolutely no ratings it is shown in ratings page" do
    visit ratings_path
    #save_and_open_page
    expect(page).to have_content "Number of ratings: 0"
  end

  it "when some has created ratings amount is shown in ratings page" do
    
    create_ratings_for_beer(1,2,3,beer1)
    create_ratings_for_beer(4,5,6,beer2)
    visit ratings_path
    #save_and_open_page
    expect(page).to have_content "Number of ratings: 6"
  end

it "when several have created ratings amount is shown in ratings page" do
    
    create_ratings_for_beer(1,2,3,beer1)
    click_link "signout"
    sign_in(username:"Pirkka", password:"Sala1")

    visit new_rating_path
    select('Karhu', from:'rating[beer_id]')
    fill_in('rating[score]', with:'7')
    expect{
      click_button "Create Rating"
    }.to change{Rating.count}.from(3).to(4)

    #user page
    expect(page).to have_content "has made 1 rating"
    
    visit ratings_path
    #save_and_open_page
    expect(page).to have_content "Number of ratings: 4"
  end
  
  it "when some has created ratings favorite style is shown in user page" do
    
    create_ratings_for_beer(1,2,3,beer1)
    create_ratings_for_beer(14,15,16,beer3)
    visit user_path(user)
    #save_and_open_page
    expect(page).to have_content "has made 6 ratings"
    expect(page).to have_content "Favorite style: Ale"
    expect(page).to have_content "Favorite brewery: Puff"

  end




  def create_ratings_for_beer(*scores, beer)
        scores.each do |score|
            FactoryGirl.create(:rating, score:score, beer:beer, user:user)
        end
  end

end