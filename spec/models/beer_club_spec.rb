require 'spec_helper'

describe BeerClub do

    it "is saved with proper name and style" do
        beer_club = BeerClub.create name:"Konalan kaljakerho", founded:2001, city:"Helsinki"

        expect(beer_club.valid?).to be(true)
        expect(BeerClub.count).to eq(1)
  
    end
end