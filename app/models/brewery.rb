class Brewery < ActiveRecord::Base
    include CalculateAverage
    validate :year_must_be_between_1042_and_this_year

    has_many :beers, :dependent => :destroy
    has_many :ratings, :through => :beers


    validates :name, presence: true
    
    validates_numericality_of :year,    {:only_integer => true}
  
    #tested with changing the system clock  
    def year_must_be_between_1042_and_this_year
      if year.present? && year < 1042 || year.present? && year > Time.new.year
         errors.add(:year, "must be equal or between 1042 and this year")
      end
    end

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
