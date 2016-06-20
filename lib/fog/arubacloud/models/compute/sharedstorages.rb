#
# Author:: Dangleterre Michaël
# © Copyright ArubaCloud.
#
# LICENSE: MIT (http://opensource.org/licenses/MIT)
#

require 'fog/core/collection'
require 'fog/arubacloud/models/compute/sharedstorages'

module Fog
  module Compute
    class ArubaCloud
      class SharedStorages < Fog::Collection
        model Fog::Compute::ArubaCloud::SharedStorage
      end
    end
  end
end