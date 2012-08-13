module HotelsPro
  module Api
    include Virtus

    def perform
      request = Request.new(self.class.name, attributes)
      request.perform
    end
  end
end