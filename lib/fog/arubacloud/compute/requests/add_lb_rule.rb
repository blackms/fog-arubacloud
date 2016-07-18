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
  module ArubaCloud
    class Compute
      class Real
        def add_lb_rule(data)
          body = self.body('SetModifyLoadBalancer').merge(
              :LoadBalancerStartRequest => {
                  :loadBalancerID => data[:id],
                  :NewLoadBalancerRule => [
                      {
                          :BalanceType => data[:balancetype],
                          :Certificate => data[:certificate],
                          :CreationDate => data[:creationdate],
                          :ID => data[:ruleid],
                          :InstancePort => data[:instanceport],
                          :LoadBalancerPort => data[:loadbalancerport],
                          :Protocol => data[:protocol]
                      }
                  ]
              }
          )
          options = {
              :http_method => :post,
              :method => 'SetModifyLoadBalancer',
              :body => Fog::JSON.encode(body)
          }

          response = nil
          time = Benchmark.realtime {
            response = request(options)
          }
          Fog::Logger.debug("SetModifyLoadBalancer time: #{time}")
          if response['Success']
            response
          else
            raise Fog::ArubaCloud::Errors::RequestError.new('Error during the request.')
          end
        end # add_lb_rule
        class Mock
          def add_lb_rule
            raise Fog::Errors::MockNotImplemented.new(
                      'Mock not implemented. Feel free to contribute.'
                  )
          end # add_lb_rule
        end # Mock
      end # Real
    end # ArubaCloud
  end # Compute
end # Fog