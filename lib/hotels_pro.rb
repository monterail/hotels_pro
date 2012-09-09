require 'rubygems'
require 'bundler/setup'
require 'active_support'
require 'json'
require 'typhoeus'
require 'virtus'

require "hotels_pro/api/api_params"
require "hotels_pro/api/api_method"
require "hotels_pro/api/elements/daily_rate"
require "hotels_pro/api/elements/filter"
require "hotels_pro/api/elements/room_response"
require "hotels_pro/api/elements/hotel"
require "hotels_pro/api/elements/pax"
require "hotels_pro/api/elements/pax_array"
require "hotels_pro/api/methods/allocate_hotel_code"
require "hotels_pro/api/methods/get_available_hotel"
require "hotels_pro/api/methods/make_hotel_booking"
require "hotels_pro/configuration"
require "hotels_pro/query"
require "hotels_pro/request"
require "hotels_pro/response"
require "hotels_pro/stubs"
require "hotels_pro/stubs/stub"
require "hotels_pro/underscorer"
require "hotels_pro/version"

module HotelsPro
  class << self
    def configuration
      @configuration ||= Configuration.new
    end

    def configure
      yield(configuration)
    end

    def log(message)
      if configuration.logger
        configuration.logger.info("[HotelsPro] #{message}")
      end
    end

    def get_available_hotel(options={})
      HotelsPro::Api::Methods::GetAvailableHotel.new(options).perform
    end

    def allocate_hotel_code(options={})
      HotelsPro::Api::Methods::AllocateHotelCode.new(options).perform
    end
  end

  class ErrorResponse < ::StandardError
  end

  class RemoteError < ::StandardError
  end

  class UnstubbedRequest < ::StandardError
  end
end
