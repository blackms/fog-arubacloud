#
# Author:: Dangleterre Michaël
# © Copyright ArubaCloud.
#
# LICENSE: MIT (http://opensource.org/licenses/MIT)
#

require 'fog/arubacloud/service'
require 'fog/arubacloud/error'
require 'benchmark'


module Fog
  module Compute
    class ArubaCloud
      class Real
        def get_custom_templates
          body = self.body('GetAvailablePersonalTemplates')
          options = {
              :http_method => :post,
              :method => 'GetAvailablePersonalTemplates',
              :body => Fog::JSON.encode(body)
          }
          response = nil
          time = Benchmark.realtime {
            response = request(options)
          }
          Fog::Logger.debug("GetAvailablePersonalTemplates time: #{time}")
          if response['Success']
            response
          else
            raise Fog::ArubaCloud::Errors::RequestError.new('Error in request.')
          end

        end # get_custom_templates
        class Mock
          def get_custom_templates
            raise Fog::Errors::MockNotImplemented.new(
                      'Mock not implemented. Feel free to contribute.'
                  )
          end # get_custom_templates
        end # Mock
      end # Real
    end # ArubaCloud
  end # Compute
end # Fog