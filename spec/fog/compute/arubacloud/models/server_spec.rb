require 'spec_helper'
require 'fog/arubacloud/models/compute/server'
require 'fog/arubacloud'

describe Fog::Compute::ArubaCloud::Server do
  include ModelSetup
  # :service is already took from ModelSetup, no need to redefine it

  let (:server_class) do
    class Fog::Compute::ArubaCloud::Server
      def self.read_identity
        instance_variable_get('@identity')
      end
    end
    Fog::Compute::ArubaCloud::Server
  end

  let(:server) { Fog::Compute::ArubaCloud::Server.new }
  let(:collection) { Object.new }
  let(:service) { Object.new }


#  it 'should respond to #collection_name' do
#    assert server_class.respond_to? :collection_name
#  end

#  it 'should have a collection name' do
#    server_class.collection_name.must_equal(:servers)
#  end


  it 'should have an unique id' do
    server_class.read_identity.must_equal(:id)
  end

  it 'should have 18 attributes' do
    server_class.attributes.must_equal([
                                           :id,
                                           :name,
                                           :state,
                                           :memory,
                                           :cpu,
                                           :hypervisor,
                                           :datacenter_id,
                                           :hd_qty,
                                           :hd_total_size,
                                           :smart_ipv4,
                                           :smart_package,
                                           :vnc_port,
                                           :admin_passwd,
                                           :vm_type,
                                           :ipv4_addr,
                                           :package_id,
                                           :template_id,
                                           :template_description
                                       ])
  end

  describe '#ready?' do
    describe 'when the machine is ready' do
      before :each do
        server.state = 3
      end

      it 'should return true' do
        server.stub(:reload, true) do
          server.ready?.must_equal true
        end
      end
    end

    describe 'when the machine is not in ready state' do
      before :each do
        server.state = 1
      end

      it 'should return false' do
        server.stub(:reload, true) do
          server.ready?.must_equal false
        end
      end
    end
  end

  describe '#stopped?' do
    describe 'when its stopped' do
      before :each do
        server.state = 2
      end

      it 'should return true' do
        server.stub(:reload, true) do
          server.stopped?.must_equal true
        end
      end
    end

    describe 'when its not stopped' do
      before :each do
        server.state = 1
      end

      it 'should return false' do
        server.stopped?.must_equal false
      end
    end

    describe 'when its in creating state' do
      describe 'when its in create state' do
        before :each do
          server.state = 1
        end

        it 'should return true' do
          server.stub(:reload, true) do
            server.creating?.must_equal true
          end
        end
      end

      describe 'when its in a different state' do
        before :each do
          server.state = 4
        end

        it 'should return false' do
          server.stub(:reload, true) do
            server.creating?.must_equal false
          end
        end
      end
    end

    describe '#power_on' do
      describe 'on a poweron vm' do
        before :each do
          server.identity = 154033
          server.state = 3
        end

        it 'should return Fog::ArubaCloud::Errors::VmStatus' do
          server.stub(:service, service) do
            proc {server.power_on}.must_raise(Fog::ArubaCloud::Errors::VmStatus)
          end
        end
      end
    end

    describe '#power_off' do
      describe 'on a powered off vm' do
        before :each do
          server.identity = 234234
          server.state = 2
        end

        it 'should return Fog::ArubaCloud::Errors::VmStatus' do
          server.stub(:service, service) do
            proc {server.power_off}.must_raise(Fog::ArubaCloud::Errors::VmStatus)
          end
        end
      end
    end

  end
end