module EventMachine
  module Plivo
    class RestAPI < ::Plivo::RestAPI
      def initialize(*args)
        if args.last.is_a? Hash
          opts = args.pop
          args += opts.values_at(:url, :version).compact
          @keepalive = opts[:keepalive] == true
        else
          @keepalive = false
        end

        super(*args)
      end

      def request(method, path, params = nil)
        params ||= {}
        method = method.downcase

        full_path = File.join(@version, 'Account', @auth_id, path)
        options = {
          :keepalive => @keepalive,
          :path => full_path,
          :head => {
            'User-Agent' => 'RubyPlivo',
            'Authorization' => [@auth_id, @auth_token]
          }
        }

        deferrable = EM::DefaultDeferrable.new

        case method
        when 'post'
          options[:head]['Content-Type'] = 'application/json'
          options[:body] = MultiJson.dump(params)
        when 'get', 'delete'
          options[:query] = params
        else
          EM.next_tick{deferrable.fail('Method Not Supported')}
          return deferrable
        end

        connection = if @keepalive
          @alive_connection ||= EM::HttpRequest.new(@url)
        else
          EM::HttpRequest.new(@url)
        end

        http = connection.public_send(method, options)

        http.callback do
          response = begin
            MultiJson.load(http.response)
          rescue MultiJson::ParseError
            nil
          end
          deferrable.succeed(http.response_header.status, response)
        end

        http.errback do
          deferrable.fail(http.error)
        end

        deferrable
      end
    end
  end
end
