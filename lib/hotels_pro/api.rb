module HotelsPro
  module Api
    include Virtus

    def perform
      api_method = self.class.name.to_s.demodulize
      request = Request.new(api_method, attributes)
      request.perform
    end
  end
end