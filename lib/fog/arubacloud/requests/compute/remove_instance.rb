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
        def remove_instance(data)
          body = self.body('SetEnqueueLoadBalancerRemoveInstances').merge(
              :Instances => {
                  :loadBalancerID => data[:id],
                  :Instances => [
                      {
                          :LoadBalancerInstance => [
                              {
                                  :IPAddress => data[:ipaddress]
                              }
                          ]
                      }
                  ]
              }
          )
          options = {
              :http_method => :post,
              :method => 'SetEnqueueLoadBalancerRemoveInstances',
              :body => Fog::JSON.encode(body)
          }

          response = nil
          time = Benchmark.realtime {
            response = request(options)
          }
          Fog::Logger.debug("SetEnqueueLoadBalancerRemoveInstances time: #{time}")
          if response['Success']
            response
          else
            raise Fog::ArubaCloud::Errors::RequestError.new('Error during the request.')
          end
        end # remove_instance
        class Mock
          def remove_instance
            raise Fog::Errors::MockNotImplemented.new(
                      'Mock not implemented. Feel free to contribute.'
                  )
          end # remove_instance
        end # Mock
      end # Real
    end # ArubaCloud
  end # Compute
end # Fog