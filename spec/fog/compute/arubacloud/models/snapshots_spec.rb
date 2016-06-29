require File.expand_path('spec/spec_helper')
require 'fog/arubacloud/models/compute/snapshots'

describe Fog::Compute::ArubaCloud::Snapshot do
  subject { Fog::Compute::ArubaCloud::Snapshots }

  it 'should be a collection of Snapshot' do
    subject.model.must_equal(Fog::Compute::ArubaCloud::Snapshot)
  end

end