module HotelsPro
  module Api
    module Elements
      class DailyRate
        include Virtus

        attribute :date, Date
        attribute :amount, Float
      end
    end
  end
end