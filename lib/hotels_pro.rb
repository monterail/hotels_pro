require 'rubygems'
require 'bundler/setup'
require 'active_support'
require 'virtus'

require "hotels_pro/api"
require "hotels_pro/api/get_available_hotel"
require "hotels_pro/configuration"
require "hotels_pro/request"
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
