module HotelsPro
  module Api
    class DailyRate
      include Virtus

      attribute :date, Date
      attribute :amount, Float
    end
  end
end