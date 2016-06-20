#
# Author:: Dangleterre Michaël
# © Copyright ArubaCloud.
#
# LICENSE: MIT (http://opensource.org/licenses/MIT)
#

require 'fog/core/collection'
require 'fog/arubacloud/models/compute/custom_templates'

module Fog
  module Compute
    class ArubaCloud
      class Custom_Templates < Fog::Collection
        model Fog::Compute::ArubaCloud::Custom_Templates
      end
    end
  end
end