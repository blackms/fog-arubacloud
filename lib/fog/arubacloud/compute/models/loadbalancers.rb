#
# Author:: Dangleterre Michaël
# © Copyright ArubaCloud.
#
# LICENSE: MIT (http://opensource.org/licenses/MIT)
#

require 'fog/core/collection'
require 'fog/arubacloud/compute/models/loadbalancer'


module Fog
  module ArubaCloud
    class Compute
      class LoadBalancers < Fog::Collection
        model Fog::ArubaCloud::Compute::LoadBalancer
      end # Load Balancers
    end # ArubaCloud
  end # Compute
end # Fog