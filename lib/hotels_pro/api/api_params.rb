require 'active_support'

module HotelsPro
  module Api
    module ApiParams
      def to_api_params
        attributes.inject({}) do |params, (k, v)|
          unless v.nil? or (v.respond_to?(:empty?) and v.empty?)
            params[api_param_name(k)] = api_param_value(v)
          end
          params
        end
      end

      def api_param_name(attribute)
        attribute.to_s.camelize(:lower)
      end

      def api_param_value(value)
        if value.is_a?(Enumerable)
          value.map{ |element| api_param_value(element) }
        else
          value.respond_to?(:to_api_params) ? value.to_api_params : value.to_s
        end
      end
    end
  end
end