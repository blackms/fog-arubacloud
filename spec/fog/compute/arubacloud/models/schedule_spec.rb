require 'spec_helper'
require 'fog/arubacloud/models/compute/schedule'
require 'fog/arubacloud'

describe Fog::Compute::ArubaCloud::Schedule do
  include ModelSetup

  let (:schedule_class) do
    class Fog::Compute::ArubaCloud::Schedule
      def self.read_identity
        instance_variable_get('@identity')
      end
    end
    Fog::Compute::ArubaCloud::Schedule
  end

  #let(:service) { Object.new }
  let(:schedule) { Fog::Compute::ArubaCloud::Schedule.new }

  it 'should have an unique id' do
    schedule_class.read_identity.must_equal(:id)
  end

  it 'should have 15 attributes' do
    schedule_class.attributes.must_equal([
                                             :id,
                                             :name,
                                             :OperationId,
                                             :ServerId,
                                             :OperationType,
                                             :OperationLabel,
                                             :dateStart,
                                             :dateEnd,
                                             :frequencyType,
                                             :ScheduleDaysOfMonth,
                                             :monthlyRecurrence,
                                             :ScheduleWeekDays,
                                             :daysOfMonth,
                                             :daysOfWeek,
                                             :frequency
                                         ])
  end

  it 'should respond to #get_scheduled_operations' do
    schedule.respond_to? :get_scheduled_operations
  end

  it 'should respond to #create_scheduled_operation' do
    schedule.respond_to? :create_scheduled_operation
  end

  it 'should respond to #create_scheduled_occurrence' do
    schedule.respond_to? :create_scheduled_occurrence
  end

  it 'should respond to #suspend_scheduled_operation' do
    schedule.respond_to? :suspend_scheduled_operation
  end

  describe '#get_scheduled_operations' do
    describe 'without correct parameters' do
      before :each do
        schedule.dateStart = nil
        schedule.dateEnd = nil
      end

      it 'should raise ArgumentError' do
        schedule.stub(:service, service) do
          proc {schedule.get_scheduled_operations}.must_raise ArgumentError
        end
      end
    end
  end

  describe '#create_scheduled_operation' do
    before :each do
      schedule.ServerId = 12342
      schedule.OperationType = 1
      schedule.OperationLabel = nil
      schedule.dateStart = Time.new
      schedule.dateEnd = Time.new
      schedule.name = 'lbtest'
    end
    describe 'without ServerId' do
      before :each do
        schedule.ServerId = nil
      end

      it 'should raise ArgumentError' do
        Fog.mock!
        schedule.stub(:service, service) do
          schedule.create_scheduled_operation.must_raise ArgumentError
        end
      end
    end
  end
end