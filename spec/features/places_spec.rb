require 'spec_helper'

describe "Places" do
  it "if one is returned by the API, it is shown at the page" do
    BeermappingApi.stub(:places_in).with("kumpula").and_return(
        [ Place.new(:name => "Oljenkorsi") ]
    )

    visit places_path
    fill_in('city', with: 'kumpula')
    click_button "Search"

    expect(page).to have_content "Oljenkorsi"
  end

  it "if three is returned by the API, three is shown at the page" do
    BeermappingApi.stub(:places_in).with("kumpula").and_return(
        [ Place.new(:name => "Oljenkorsi"), Place.new(:name => "Kukkulan kuohu"), Place.new(:name => "Maauimalan mallas")  ]
    )

    visit places_path
    fill_in('city', with: 'kumpula')
    click_button "Search"

    expect(page).to have_content "Oljenkorsi"
    expect(page).to have_content "Kukkulan kuohu"
    expect(page).to have_content "Maauimalan mallas"
  end

  it "if none is returned by the API, notification is shown at the page" do
    BeermappingApi.stub(:places_in).with("koskela").and_return(
        [  ]
    )

    visit places_path
    fill_in('city', with: 'koskela')
    click_button "Search"

    expect(page).to have_content "No places in koskela"
  end
end