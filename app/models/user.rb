class User < ActiveRecord::Base
    include CalculateAverage

    validates :username, uniqueness: true, 
                         length: { minimum: 3, :maximum => 15 }
                         
    has_many :ratings, dependent: :destroy
    has_many :beers, through: :ratings
    has_many :memberships
    has_many :beer_clubs, through: :memberships

    def to_s
        "#{username}"
    end
end
