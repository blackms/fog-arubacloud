require File.expand_path('spec/spec_helper')
require 'fog/arubacloud/models/compute/disks'

describe Fog::Compute::ArubaCloud::Disks do
  subject { Fog::Compute::ArubaCloud::Disks }

  it 'should be a collection of Disk' do
    subject.model.must_equal(Fog::Compute::ArubaCloud::Disk)
  end

end