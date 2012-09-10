module HotelsPro
  module Api
    module Methods
      class GetHotelCancellationPolicy < ApiMethod
        include ApiParams
        include Virtus

        attribute :tracking_id, String

        class Result < ApiMethod::Result
          attribute :response_id, Integer
          attribute :tracking_id, String
          attribute :agency_reference_number, String
          attribute :cancellation_policy, Array[HotelsPro::Api::Elements::Policy], :default => []
        end
      end
    end
  end
end
