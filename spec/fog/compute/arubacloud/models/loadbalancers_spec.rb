require File.expand_path('spec/spec_helper')
require 'fog/arubacloud/models/compute/loadbalancers'

describe Fog::Compute::ArubaCloud::LoadBalancers do
  # lazy loader (same as let(:subject) { Fog::Compute::ArubaCloud::LoadBalancers })
  subject { Fog::Compute::ArubaCloud::LoadBalancers }

  it 'should be a collection of LoadBalancers' do
    subject.model.must_equal(Fog::Compute::ArubaCloud::LoadBalancer)
  end

  it 'respond to #disks' do
    subject.model.respond_to? :disks
  end
end