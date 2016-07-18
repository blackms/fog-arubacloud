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
        def get_notifications(data)
          body = self.body('GetLoadBalancerNotifications').merge(
              :request => {
                  :loadBalancerID => data[:id],
                  :EndDate => data[:endtime],
                  :StartDate => data[:starttime],
                  :LoadBalancerRuleID => data[:ruleid]
              }
          )
          options = {
              :http_method => :post,
              :method => 'GetLoadBalancerNotifications',
              :body => Fog::JSON.encode(body)
          }

          response = nil
          time = Benchmark.realtime {
            response = request(options)
          }
          Fog::Logger.debug("GetLoadBalancerNotifications time: #{time}")
          if response['Success']
            response
          else
            raise Fog::ArubaCloud::Errors::RequestError.new('Error during the request.')
          end
        end # get_notifications
        class Mock
          def get_notifications
            raise Fog::Errors::MockNotImplemented.new(
                      'Mock not implemented. Feel free to contribute.'
                  )
          end # get_notifications
        end # Mock
      end # Real
    end # ArubaCloud
  end # Compute
end # Fog