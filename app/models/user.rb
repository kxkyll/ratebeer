class User < ActiveRecord::Base
    include CalculateAverage

    validates :username, uniqueness: true, 
                         length: { minimum: 3, :maximum => 15 }
                         
    has_many :ratings, :dependent => :destroy

    def to_s
        "#{username}"
    end
end
