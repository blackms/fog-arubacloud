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
        def add_contact(data)
          body = self.body('SetAddLoadBalancerContacts').merge(
              :request => {
                  :loadBalancerID => data[:id],
                  :NotificationContacts => [
                      {
                          :NotificationContact => [
                              {
                                  :ContactValue => data[:contactvalue],
                                  :LoadBalancerContactID => data[:loadbalancercontactid],
                                  :Type => data[:type]
                              }
                          ]
                      }
                  ]
              }
          )
          options = {
              :http_method => :post,
              :method => 'SetAddLoadBalancerContacts',
              :body => Fog::JSON.encode(body)
          }

          response = nil
          time = Benchmark.realtime {
            response = request(options)
          }
          Fog::Logger.debug("SetAddLoadBalancerContacts time: #{time}")
          if response['Success']
            response
          else
            raise Fog::ArubaCloud::Errors::RequestError.new('Error during the request.')
          end
        end # add_contact
        class Mock
          def add_contact
            raise Fog::Errors::MockNotImplemented.new(
                      'Mock not implemented. Feel free to contribute.'
                  )
          end # add_contact
        end # Mock
      end # Real
    end # ArubaCloud
  end # Compute
end # Fog