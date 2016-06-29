require File.expand_path('spec/spec_helper')
require 'fog/arubacloud/models/compute/disk'

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
  let(:disk) { Fog::Compute::ArubaCloud::Disk.new }

  it 'must respond to #create' do
    disk.must_respond_to :create
  end

  describe '#create' do
    describe 'passing a wrong disk size >500GB' do
      before :each do
        disk.size = 600
        disk.virtual_disk_type = 1
      end

      it 'should raise BadDiskSize' do
        disk.stub(:service, service) do
          proc {disk.create}.must_raise Fog::ArubaCloud::Errors::BadDiskSize
        end
      end
    end

    describe 'passing wrong disk type (> 3)' do
      before :each do
        disk.size = 100
        disk.virtual_disk_type = 4
      end

      it 'should raise BadDiskNumber' do
        disk.stub(:service, service) do
          proc {disk.create}.must_raise Fog::ArubaCloud::Errors::BadDiskNumber
        end
      end
    end

    describe 'passing correct values' do
      before :each do
        disk.size = 100
        disk.virtual_disk_type = 1
      end

      it 'should return' do
        disk.stub(:service, service) do
          disk.create
        end
      end
    end
  end
end