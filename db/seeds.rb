# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
User.create username: "A1kati", password: "A1kati", password_confirmation: "A1kati", admin:true
User.create username: "Pasi1", password: "Pasi1", password_confirmation: "Pasi1", admin:false


s1 = Style.create name: "Ale", description: "Ale is a kind of a beer that is brewed from"
s2 = Style.create name: "Weizen", description: "Wheet beer"
s3 = Style.create name: "Lager", description: "Fermented and conditioned with low temperatures. Most widely consumed beer style."
s4 = Style.create name: "Pale Ale", description: "Beer made with warm fermentation using pale malt"
s5 = Style.create name: "IPA", description: "India Pale Ale"
s6 = Style.create name: "Porter", description: "Dark style beer"

b1 = Brewery.create name:"Koff", year:1897
b2 = Brewery.create name:"Malmgard", year:2001
b3 = Brewery.create name:"Weihenstephaner", year:1042

b1.beers.create name:"Iso 3", style_id:3
b1.beers.create name:"Karhu", style_id:3
b1.beers.create name:"Tuplahumala", style_id:3
b2.beers.create name:"Huvila Pale Ale", style_id:4
b2.beers.create name:"X Porter", style_id:6
b3.beers.create name:"Hefezeizen", style_id:2
b3.beers.create name:"Helles", style_id:3

Settings.beermapping_apikey = "8efe2ddeac2e5dca97731d3907ed473b"
Settings.save

