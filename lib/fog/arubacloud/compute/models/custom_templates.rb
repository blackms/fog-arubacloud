#
# Author:: Dangleterre Michaël
# © Copyright ArubaCloud.
#
# LICENSE: MIT (http://opensource.org/licenses/MIT)
#

require 'fog/core/collection'
require 'fog/arubacloud/compute/models/custom_templates'

module Fog
  module ArubaCloud
    class Compute
      class Custom_Templates < Fog::Collection
        model Fog::ArubaCloud::Compute::Custom_Templates
      end
    end
  end
end