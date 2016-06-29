require File.expand_path('spec/spec_helper')
require 'fog/arubacloud/models/compute/network_adapters'

describe Fog::Compute::ArubaCloud::NetworkAdapters do
  # lazy loader (same as let(:subject) { Fog::Compute::ArubaCloud::NetworkAdapters })
  subject { Fog::Compute::ArubaCloud::NetworkAdapters }

  it 'should be a collection of NetworkAdapter' do
    subject.model.must_equal(Fog::Compute::ArubaCloud::NetworkAdapter)
  end
end