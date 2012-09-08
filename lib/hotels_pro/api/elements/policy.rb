module HotelsPro
  module Api
    module Elements
      class Policy
        include Virtus

        attribute :cancellation_day, Integer
        attribute :fee_type, String
        attribute :fee_amount, Float
        attribute :currency, String
        attribute :remarks, String
      end
    end
  end
end
