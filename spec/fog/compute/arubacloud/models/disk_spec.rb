require 'spec_helper'
require 'fog/arubacloud/models/compute/disk'
require 'fog/arubacloud'

describe Fog::Compute::ArubaCloud::Disk do
  include ModelSetup

  let (:disk_class) do
    class Fog::Compute::ArubaCloud::Disk
      def self.read_identity
        instance_variable_get('@identity')
      end
    end
    Fog::Compute::ArubaCloud::Disk
  end

  let(:service) { Object.new }
end