require 'spec_helper'
require 'fog/arubacloud/models/compute/ip'
require 'fog/arubacloud'

describe Fog::Compute::ArubaCloud::IP do
  include ModelSetup

  let (:ip_class) do
    class Fog::Compute::ArubaCloud::IP
      def self.read_identity
        instance_variable_get('@identity')
      end
    end
    Fog::Compute::ArubaCloud::IP
  end

  let(:service) { Object.new }
  let(:ip) { Fog::Compute::ArubaCloud::IP.new }

  it 'must respond to #purchase' do
    ip.must_respond_to :purchase
  end

  it 'must respond to #remove' do
    ip.must_respond_to :remove
  end

  describe '#remove' do
    describe 'without ServerId set' do
      before :each do
        ip.id = nil
      end

      it 'should raise ArgumentError' do
        ip.stub(:service, service) do
          proc {ip.remove}.must_raise ArgumentError
        end
      end
    end

    describe 'still attached to the server' do
      before :each do
        ip.id = 23432
        ip.server = 3254324
      end

      it 'should raise RequestError' do
        ip.stub(:service, service) do
          proc {ip.remove}.must_raise Fog::ArubaCloud::Errors::RequestError
        end
      end
    end
  end
end