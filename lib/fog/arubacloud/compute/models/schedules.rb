#
# Author:: Dangleterre Michaël
# © Copyright ArubaCloud.
#
# LICENSE: MIT (http://opensource.org/licenses/MIT)
#

require 'fog/core/collection'
require 'fog/arubacloud/compute/models/schedule'

module Fog
  module ArubaCloud
    class Compute
      class Schedules < Fog::Collection
        model Fog::ArubaCloud::Compute::Schedules
      end
    end
  end
end