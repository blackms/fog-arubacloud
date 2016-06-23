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

  it 'should have 14 attributes' do
    schedule_class.attributes.must_equal([
                                             :id,
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
end