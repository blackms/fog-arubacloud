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
        def delete_custom_template(data)
          body = self.body('SetRemovePersonalTemplate').merge(
              :template => {
                  :templateID => data[:id]
              }
          )
          options = {
              :http_method => :post,
              :method => 'SetRemovePersonalTemplate',
              :body => Fog::JSON.encode(body)
          }

          response = nil
          time = Benchmark.realtime {
            response = request(options)
          }
          Fog::Logger.debug("SetRemovePersonalTemplate time: #{time}")
          if response['Success']
            response
          else
            raise Fog::ArubaCloud::Errors::RequestError.new('Error during the request.')
          end

        end # delete_custom_template
        class Mock
          def delete_custom_template
            raise Fog::Errors::MockNotImplemented.new(
                      'Mock not implemented. Feel free to contribute.'
                  )
          end # delete_custom_template
        end # Mock
      end # Real
    end # ArubaCloud
  end # Compute
end # Fog