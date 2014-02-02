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
end
