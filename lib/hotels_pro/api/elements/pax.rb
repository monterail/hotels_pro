module HotelsPro
  module Api
    module Elements
      class Pax
        include ApiParams
        include Virtus

        attribute :pax_type, String
        attribute :age, Integer
        attribute :title, String
        attribute :first_name, String
        attribute :last_name, String
      end
    end
  end
end