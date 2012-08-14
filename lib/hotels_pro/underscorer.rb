module HotelsPro
  module Underscorer
    # Detect nested hashes and underscore their keys
    def underscore(object)
      case object
      when Hash
        object.inject({}) do |hash, (k, v)|
          hash[k.underscore] = underscore(v)
          hash
        end
      when Array
        object.inject([]) do |arr, element|
          arr << underscore(element)
          arr
        end
      else
        object
      end
    end
  end
end