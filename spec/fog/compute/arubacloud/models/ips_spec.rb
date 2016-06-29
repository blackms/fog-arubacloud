require File.expand_path('spec/spec_helper')
require 'fog/arubacloud/models/compute/ips'

describe Fog::Compute::ArubaCloud::Ips do
  subject { Fog::Compute::ArubaCloud::Ips }

  it 'should be a collection of IP' do
    subject.model.must_equal(Fog::Compute::ArubaCloud::IP)
  end

end