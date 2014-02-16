class BeermappingApi
   def self.places_in(city)
    city = city.downcase
    Rails.cache.fetch(city, :expires_in => 1.hour) { fetch_places_in(city) }
    
  end

  def self.pubs_in(city, id)
   
    places = Rails.cache.read(city)
    places.find{ |p| p.id == id}

  end

  
  private

  def self.fetch_places_in(city)
    url = "http://beermapping.com/webservice/loccity/#{key}/"

    response = HTTParty.get "#{url}#{ERB::Util.url_encode(city)}"
    places = response.parsed_response["bmp_locations"]["location"]

    return [] if places.is_a?(Hash) and places['id'].nil?

    places = [places] if places.is_a?(Hash)
    places.inject([]) do | set, place |
      set << Place.new(place)
    end
  end

  def self.key
    Settings.beermapping_apikey
    #"8efe2ddeac2e5dca97731d3907ed473b"
    #Aseta konsolista käsin arvo apikey:lle seuraavalla komennolla
    #Settings.beermapping_apikey = "8efe2ddeac2e5dca97731d3907ed473b"
  end

end