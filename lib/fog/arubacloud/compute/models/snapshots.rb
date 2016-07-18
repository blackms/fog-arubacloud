#
# Author:: Dangleterre Michaël
# © Copyright ArubaCloud.
#
# LICENSE: MIT (http://opensource.org/licenses/MIT)
#

require 'fog/core/collection'
require 'fog/arubacloud/compute/models/snapshot'

module Fog
  module ArubaCloud
    class Compute
      class Snapshots < Fog::Collection
        model Fog::ArubaCloud::Compute::Snapshot
      end
    end
  end
end