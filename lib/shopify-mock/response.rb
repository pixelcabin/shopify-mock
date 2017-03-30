module ShopifyAPI
  module Mock
    # used to manage the mocked responses
    class Response
      # creates and registers a new mocked response
      # @param [Symbol] method The method of the reponse. Can be one of [:put, :get, :post, :delete]
      # @param [String] resource The path to the resource.
      # @param [String] response The response to provide when that URL is called
      # @return [FakeWeb] The FakeWeb object for the mocked response
      # @example Registering a response to the path "/orders/count.xml" with the response "hello world"
      #   ShopifyAPI::Mock::Response.new :get, "orders/count.xml", "hello world"
      # @api public
      def initialize(method, resource, response)
        req = ActiveResource::Request.new(method, '/admin/'+resource, nil, ShopifyAPI::Base.headers)
        res = ActiveResource::Response.new(response)
        @@responses[req] = res
        ActiveResource::HttpMock.respond_to({req => res}, false)
        # @@responses += FakeWeb.register_uri(
        #   method, /#{SHOPIFY_MOCK_SHOP_BASE_URL}#{resource}/,
        #   :body => response
        # )
      end

      class << self
        # store for all registered responses
        @@responses = {}

        # finds all the registered responses
        # @return [Array, FakeWeb] all the FakeWeb registered responses
        # @example List all the registered responses
        #   puts ShopifyAPI::Mock::Response.all
        # @api public
        def all
          @@responses
        end

        # clears all the currently registered responses
        # @return [Array] the registered responses after clearing (should be empty)
        # @example Clearing all registered responses
        #   ShopifyAPI::Mock::Response.clear
        # @api public
        def clear
          ActiveResource::HttpMock.reset!
          @@responses = {}
        end
      end
    end
  end
end
