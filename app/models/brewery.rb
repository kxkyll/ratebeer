class Brewery < ActiveRecord::Base
    include CalculateAverage

    validates :name, presence: true
    validates_numericality_of :year,    {:greater_than_or_equal_to => 1042,
                                        :less_than_or_equal_to => 2014,
                                        :only_integer => true}
  

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
