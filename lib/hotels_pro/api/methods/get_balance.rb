module HotelsPro
  module Api
    module Methods
      class GetBalance < ApiMethod
        include ApiParams
        include Virtus

        class Result < ApiMethod::Result
          attribute :response_id, Integer
          attribute :currency, String
          attribute :total_deposit, Float
          attribute :total_booking_amount, Float
          attribute :current_balance, Float
        end
      end
    end
  end
end
