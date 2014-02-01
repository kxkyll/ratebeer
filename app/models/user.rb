class User < ActiveRecord::Base
    include CalculateAverage

    has_secure_password
    validates :username, uniqueness: true, 
                         length: { minimum: 3, :maximum => 15 }

    validates_length_of :password, :minimum => 4
    validates_format_of :password, :with => /[0-9]+[A-Z]+/
                         
    has_many :ratings, dependent: :destroy
    has_many :beers, through: :ratings
    has_many :memberships
    has_many :beer_clubs, through: :memberships

    def to_s
        "#{username}"
    end
end
