module RailsActionDeprecation
  module Controller
    extend ActiveSupport::Concern

    module ClassMethods
      def deprecate_endpoint(datetime, only: nil)
        # Deliver the (draft) Deprecation HTTP header with the response
        # https://datatracker.ietf.org/doc/html/draft-ietf-httpapi-deprecation-header
        deprecation 'Deprecation', datetime, only: only
      end

      def sunset_endpoint(datetime, only: nil)
        # Deliver the Sunset HTTP header with the response
        # https://datatracker.ietf.org/doc/html/rfc8594
        deprecation 'Sunset', datetime, only: only
      end

      protected

      def deprecation(header, datetime, only: nil)
        after_action(only: only) do |controller|
          klass = controller.class
          user_agent = request.headers['User-Agent']
          method = params['action']
          # Log the deprecation
          ActiveSupport::Deprecation.warn("#{klass}##{method} deprecated endpoint (#{header.downcase} date #{datetime.iso8601}) has been called by #{user_agent}")

          response.headers[header] = datetime.httpdate
        end
      end
    end
  end
end