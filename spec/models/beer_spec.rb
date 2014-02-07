require 'spec_helper'

describe Beer do
  it "is saved with proper name and style" do
    beer = Beer.create name:"Lagerbeer", style:"Laber"

    expect(beer.valid?).to be(true)
    expect(Beer.count).to eq(1)
  end

  it "is not saved without a name" do
    beer = Beer.create style:"Lager"

    expect(beer.valid?).to be(false)
    expect(Beer.count).to eq(0)
  end

  it "is not saved without a style" do
    beer = Beer.create name:"Testlager"

    expect(beer.valid?).to be(false)
    expect(Beer.count).to eq(0)
  end
end
