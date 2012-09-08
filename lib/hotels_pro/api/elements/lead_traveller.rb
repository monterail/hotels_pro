require 'hotels_pro/api/elements/pax'

module HotelsPro
  module Api
    module Elements
      class LeadTraveller
        include ApiParams
        include Virtus

        attribute :pax_info, HotelsPro::Api::Elements::Pax
        attribute :nationality, String
      end
    end
  end
end
