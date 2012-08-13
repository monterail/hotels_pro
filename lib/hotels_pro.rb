require "hotels_pro/configuration"
require "hotels_pro/version"

module HotelsPro
  class << self
    attr_accessor :configuration

    def configure
      self.configuration ||= Configuration.new
      yield(configuration)
    end
  end
end
