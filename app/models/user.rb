class User < ActiveRecord::Base
    include CalculateAverage

    has_many :ratings, :dependent => :destroy

    def to_s
        "#{username}"
    end
end
