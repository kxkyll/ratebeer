class Beer < ActiveRecord::Base
    belongs_to :brewery
    has_many :ratings

    def average_rating
        #ratings.average('score')
        ratings.inject(0) { |sum, s| sum + s.score } / ratings.count
    end

    def to_s
        "#{name} #{brewery.name}" 
    end
end
