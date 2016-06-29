require File.expand_path('spec/spec_helper')
require 'fog/arubacloud/models/compute/template'

describe Fog::Compute::ArubaCloud::Template do
  include ModelSetup

  let (:template_class) do
    class Fog::Compute::ArubaCloud::Template
      def self.read_identity
        instance_variable_get('@identity')
      end
    end
    Fog::Compute::ArubaCloud::Template
  end

  #let(:service) { Object.new }
  let(:template) { Fog::Compute::ArubaCloud::Template.new }

  before :each do
    Fog.unmock!
  end

  it 'should have an unique id' do
    template_class.read_identity.must_equal(:id)
  end

  it 'should have 8 attributes' do
    template_class.attributes.must_equal([
                                             :id,
                                             :name,
                                             :description,
                                             :enabled,
                                             :export_enabled,
                                             :identification_code,
                                             :product_id,
                                             :hypervisor
                                         ])
  end
end