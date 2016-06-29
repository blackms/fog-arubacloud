require File.expand_path('spec/spec_helper')
require 'fog/arubacloud/models/compute/loadbalancer'

describe Fog::Compute::ArubaCloud::LoadBalancer do
  include ModelSetup

  let (:loadbalancer_class) do
    class Fog::Compute::ArubaCloud::LoadBalancer
      def self.read_identity
        instance_variable_get('@identity')
      end
    end
    Fog::Compute::ArubaCloud::LoadBalancer
  end

  #let(:service) { Object.new }
  let(:loadbalancer) { Fog::Compute::ArubaCloud::LoadBalancer.new }

  it 'must respond to #create_loadbalancer' do
    loadbalancer.must_respond_to :create_loadbalancer
  end

  it 'must respond to #remove_loadbalancer' do
    loadbalancer.must_respond_to :remove_loadbalancer
  end

  it 'must respond to #get_loadbalancer' do
    loadbalancer.must_respond_to :get_loadbalancer
  end

  it 'must respond to #modify_loadbalancer' do
    loadbalancer.must_respond_to :modify_loadbalancer
  end

  it 'must respond to #get_lb_stats' do
    loadbalancer.must_respond_to :get_lb_stats
  end

  it 'must respond to #get_lb_loads' do
    loadbalancer.must_respond_to :get_lb_loads
  end

  it 'must respond to #add_lb_rule' do
    loadbalancer.must_respond_to :add_lb_rule
  end

  it 'must respond to #remove_instance' do
    loadbalancer.must_respond_to :remove_instance
  end

  it 'must respond to #add_instance' do
    loadbalancer.must_respond_to :add_instance
  end

  it 'must respond to #get_notifications' do
    loadbalancer.must_respond_to :get_notifications
  end

  it 'must respond to #add_contact' do
    loadbalancer.must_respond_to :add_contact
  end

  it 'must respond to #remove_contact' do
    loadbalancer.must_respond_to :remove_contact
  end

  it 'must respond to #enable_loadbalancer' do
    loadbalancer.must_respond_to :enable_loadbalancer
  end

  it 'should have 20 attributes' do
    loadbalancer_class.attributes.must_equal([
                                             :id,
                                             :name,
                                             :starttime,
                                             :endtime,
                                             :ipaddress,
                                             :notificationcontacts,
                                             :contactvalue,
                                             :loadbalancercontactid,
                                             :type,
                                             :contactid,
                                             :ipaddressesresourceid,
                                             :healthchecknotification,
                                             :newrule,
                                             :ruleid,
                                             :balancetype,
                                             :certificate,
                                             :creationdate,
                                             :instanceport,
                                             :loadbalancerport,
                                             :protocol
                                             ])
  end

  it 'should have an unique id' do
    loadbalancer_class.read_identity.must_equal(:id)
  end

end