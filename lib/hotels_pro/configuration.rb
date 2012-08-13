module HotelsPro
  class Configuration
    attr_accessor :environment, :api_key

    def initialize
      @environment = "test"
    end

    def api_url
      env = ("" if environment == "live") || "_test"
      "http://api.hotelspro.com/4.1#{env}/hotel/b2bHotelJSON.php"
    end
  end
end