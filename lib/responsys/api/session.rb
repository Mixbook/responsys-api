module Responsys
  module Api
    class Session
      attr_accessor :credentials, :session_id, :jsession_id, :header
      include Responsys::Api::Authentication

      def initialize
        settings = Responsys.configuration.settings
        @credentials = {
          username: settings[:username],
          password: settings[:password]
        }

        ssl_version = settings[:ssl_version] || :TLSv1
        ssl_verify_mode = settings[:ssl_verify_mode] || :peer

        if settings[:debug]
          @savon_client = Savon.client(wsdl: settings[:wsdl], element_form_default: :qualified, ssl_version: ssl_version, log_level: :debug, log: true, pretty_print_xml: true, ssl_verify_mode: ssl_verify_mode)
        else
          @savon_client = Savon.client(wsdl: settings[:wsdl], element_form_default: :qualified, ssl_version: ssl_version, ssl_verify_mode: ssl_verify_mode)
        end
      end

      def run(method, message)
        @savon_client.call(method.to_sym, message: message)
      end

      def run_with_credentials(method, message)
        @savon_client.call(method.to_sym, message: message, cookies: jsession_id, soap_header: header)
      end
    end
  end
end