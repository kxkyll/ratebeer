class Brewery < ActiveRecord::Base
    include CalculateAverage

    has_many :beers, :dependent => :destroy
    has_many :ratings, :through => :beers

    def print_report
        puts self.name
        puts "established at year #{self.year}"
        puts "number of beers #{self.beers.count}"
        puts "number of ratings #{self.ratings.count}"
    end

    def restart
        self.year = 2014
        puts "changed year to #{year}"
    end

    def to_s
        "#{name}"
    end
end
