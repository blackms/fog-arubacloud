#
# Author:: Alessio Rocchi (<alessio.rocchi@staff.aruba.it>)
# © Copyright ArubaCloud.
#
# LICENSE: MIT (http://opensource.org/licenses/MIT)
#

require 'fog/core/collection'
require 'fog/arubacloud/compute/models/network_adapter'


module Fog
  module ArubaCloud
    class Compute
      class NetworkAdapters < Fog::Collection
        model Fog::ArubaCloud::Compute::NetworkAdapter
      end
    end
  end
end
