require 'spec_helper'
require 'fog/arubacloud/models/compute/snapshot'
require 'fog/arubacloud'

describe Fog::Compute::ArubaCloud::Snapshot do
  include ModelSetup

  let (:snapshot_class) do
    class Fog::Compute::ArubaCloud::Snapshot
      def self.read_identity
        instance_variable_get('@identity')
      end
    end
    Fog::Compute::ArubaCloud::Snapshot
  end

  let(:service) { Object.new }
end