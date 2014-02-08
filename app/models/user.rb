class User < ActiveRecord::Base
    include CalculateAverage

    has_secure_password
    validates :username, uniqueness: true, 
                         length: { minimum: 3, :maximum => 15 }

    validates_length_of :password, :minimum => 4
    validates_format_of :password, :with => /([a-z]*[0-9]+[a-z]*[A-Z]+[a-z]*)|([a-z]*[A-Z]+[a-z]*[0-9]+[a-z]*)/
                         
    has_many :ratings, dependent: :destroy
    has_many :beers, through: :ratings
    has_many :memberships
    has_many :beer_clubs, through: :memberships

    def to_s
        "#{username}"
    end

    def favorite_beer
        return nil if ratings.empty?
        ratings.order(score: :desc).limit(1).first.beer
    end

    def favorite_style
        return nil if ratings.empty?
        ratingsByStyle = ratings.group_by{ |r| r.beer.style}
        ratingsByStyle = ratingsByStyle.each_pair{ |style,score| ratingsByStyle[style] = score.sum(&:score) / score.size}
        ratingsByStyle.sort_by{ |style,score| score}.last[0]
    end

    def favorite_brewery
       return nil if ratings.empty?
       ratingsByBrewery = ratings.group_by{ |r| r.beer.brewery}
       ratingsByBrewery = ratingsByBrewery.each_pair{ |brewery, score| ratingsByBrewery[brewery] = score.sum(&:score) /score.size}
       ratingsByBrewery.sort_by{ |brewery, score| score}.last[0]
    end
end
