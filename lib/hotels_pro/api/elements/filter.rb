module HotelsPro
  module Api
    module Elements
      class Filter
        include ApiParams
        include Virtus

        attribute :filter_type, String
        attribute :filter_value, String
      end
    end
  end
end