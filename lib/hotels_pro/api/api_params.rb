require 'active_support'

module HotelsPro
  module Api
    module ApiParams
      def to_api_params
        attributes.inject({}) do |params, (k, v)|
          unless v.nil? or (v.respond_to?(:empty?) and v.empty?)
            params[api_param_name(k)] = v
          end
          params
        end
      end

      def api_param_name(attribute)
        attribute.to_s.camelize(false)
      end
    end
  end
end