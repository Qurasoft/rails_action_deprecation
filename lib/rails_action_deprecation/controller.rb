module RailsActionDeprecation
  module Controller
    extend ActiveSupport::Concern

    module ClassMethods
      def deprecate_endpoint(datetime, only: nil, link: nil)
        # Deliver the (draft) Deprecation HTTP header with the response
        # https://datatracker.ietf.org/doc/html/draft-ietf-httpapi-deprecation-header
        deprecation 'Deprecation', datetime, only: only, link: link
      end

      def sunset_endpoint(datetime, only: nil, link: nil)
        # Deliver the Sunset HTTP header with the response
        # https://datatracker.ietf.org/doc/html/rfc8594
        deprecation 'Sunset', datetime, only: only, link: link
      end

      protected

      def deprecation(header, datetime, only: nil, link: nil)
        after_action(only: only) do |controller|
          klass = controller.class
          user_agent = request.headers['User-Agent']
          method = params['action']
          # Log the deprecation
          ActiveSupport::Deprecation.warn("#{klass}##{method} deprecated endpoint (#{header.downcase} date #{datetime.iso8601}) has been called by #{user_agent}")

          response.set_header header, datetime.httpdate

          # Add a Link header with the correct relation if specified
          if link.present?
            link_header = "<#{link}>; rel=\"#{header.downcase}\""
            # Append if a Link header is already present
            if response.has_header? "Link"
              response.set_header "Link", "#{response.get_header("Link")}, #{link_header}"
            else
              response.set_header "Link", link_header
            end
          end
        end
      end
    end
  end
end