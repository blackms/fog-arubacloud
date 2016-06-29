require File.expand_path('spec/spec_helper')
require 'fog/arubacloud/models/compute/sharedstorage'

describe Fog::Compute::ArubaCloud::SharedStorage do
  include ModelSetup

  let (:sharedstorage_class) do
    class Fog::Compute::ArubaCloud::SharedStorage
      def self.read_identity
        instance_variable_get('@identity')
      end
    end
    Fog::Compute::ArubaCloud::SharedStorage
  end

  #let(:service) { Object.new }
  let(:sharedstorage) { Fog::Compute::ArubaCloud::SharedStorage.new }

  before :each do
    Fog.unmock!
  end

  it 'should have an unique id' do
    sharedstorage_class.read_identity.must_equal(:id)
  end

  it 'should have 15 attributes' do
    sharedstorage_class.attributes.must_equal([
                                             :id,
                                             :quantity,
                                             :value,
                                             :sharedstoragename,
                                             :sharedstorageprotocoltype,
                                         ])
  end

  it 'should respond to #create' do
    sharedstorage_class.respond_to? :create
  end

  it 'should respond to #edit' do
    sharedstorage_class.respond_to? :edit
  end

  it 'should respond to #delete' do
    sharedstorage_class.respond_to? :delete
  end

  it 'should respond to #rename' do
    sharedstorage_class.respond_to? :rename
  end

  describe 'create' do
    before :each do
      sharedstorage.sharedstorageprotocoltype = 'ISCSI'
      sharedstorage.quantity = 1
      sharedstorage.sharedstoragename = 'spectestsharedstorage'
    end

    describe 'with correct parameters' do
      it 'should raise any error' do
        Fog.mock!
        sharedstorage.stub(:service, service) do
          sharedstorage.create.must_be_kind_of(Hash)
        end
      end
    end

=begin
    describe 'when missing parameter' do
      before :each do
        sharedstorage.quantity = nil
        Fog.mock!
      end

      it 'should raise ArgumentError' do
        sharedstorage.stub(:service, service) do
          sharedstorage.create.must_raise(ArgumentError)
        end
      end

    end
=end

  end
end