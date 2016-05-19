#
# Author:: Dangleterre Michaël
# © Copyright ArubaCloud.
#
# LICENSE: MIT (http://opensource.org/licenses/MIT)
#

require 'fog/core/collection'
require 'fog/arubacloud/models/compute/shared_storages'

module Fog
  module Compute
    class ArubaCloud
      class Shared_Storages < Fog::Collection
        model Fog::Compute::ArubaCloud::Shared_Storages
      end
    end
  end
end