require "hotels_pro/configuration"
require "hotels_pro/version"

module HotelsPro
  class << self
    def configuration
      @configuration ||= Configuration.new
    end

    def configure
      yield(configuration)
    end
  end
end
