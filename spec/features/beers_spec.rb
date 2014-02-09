require 'spec_helper'

describe "Beer" do
    before :each do
        FactoryGirl.create :user
        FactoryGirl.create :brewery, name:"Koff"
        sign_in(username:"Pekka", password:"Foobar1")
    end

    it "when name given, is added to the system" do
        visit new_beer_path
        #save_and_open_page
        fill_in('beer_name', with:'BeerToBeAdded')
        

        expect{
          click_button('Create Beer')
        }.to change{Beer.count}.by(1)
    end

    it "is not saved if name blank" do
        visit new_beer_path
       expect{
          click_button('Create Beer')
        }.to change{Beer.count}.by(0) 

    end
    it "is redirected back to new beer form if no name is given" do
        visit new_beer_path
        
        expect{
          click_button('Create Beer')
        }.to change{Beer.count}.by(0) 
        # tää polku vaikutaa oudolta
        expect(current_path).to eq(beers_path)
        expect(page).to have_content "New beer"
        expect(page).to have_content "Name can't be blank"
    end
end