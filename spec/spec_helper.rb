require 'rubygems'
require 'bundler/setup'
require 'hotels_pro'

require 'request_helper'

HotelsPro.configure do |config|
  config.api_key = "123"
end