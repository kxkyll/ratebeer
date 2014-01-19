class Brewery < ActiveRecord::Base
    include CalculateAverage

    has_many :beers, :dependent => :destroy
    has_many :ratings, :through => :beers

    #def average_rating
    #    #ratings.average('score')
    #    ratings.inject(0) { |sum, s| sum + s.score } / ratings.count
    #end

    def to_s
        "#{name}"
    end
end
