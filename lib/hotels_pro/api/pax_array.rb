module HotelsPro
  module Api
    class PaxArray
      include Virtus

      attribute :elements, Array[Pax], :default => []

      def to_api_params
        elements.map(&:to_api_params)
      end
    end
  end
end