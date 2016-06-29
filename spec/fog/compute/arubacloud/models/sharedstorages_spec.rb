require 'spec_helper'
require 'fog/arubacloud/models/compute/sharedstorages'

describe Fog::Compute::ArubaCloud::SharedStorages do
  subject { Fog::Compute::ArubaCloud::SharedStorages }

  it 'should be a collection of SharedStorage' do
    subject.model.must_equal(Fog::Compute::ArubaCloud::SharedStorage)
  end
end