require 'hotels_pro/api/elements/pax'

module HotelsPro
  module Api
    module Elements
      class PaxArray
        include Virtus

        attribute :elements, Array[Pax], :default => []

        def to_api_params
          elements.map(&:to_api_params)
        end
      end
    end
  end
end