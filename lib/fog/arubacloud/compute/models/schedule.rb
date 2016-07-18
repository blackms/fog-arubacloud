#
# Author:: Dangleterre Michaël
# © Copyright ArubaCloud.
#
# LICENSE: MIT (http://opensource.org/licenses/MIT)
#

require 'fog/core/model'
require 'fog/arubacloud/error'

module Fog
  module ArubaCloud
    class Compute
      class Schedule < Fog::Model
        ADD = 'Add'
        EDIT = 'Edit'
        SUSPEND = 'Suspend'
        DELETE = 'Delete'

        identity :id, :aliases => 'OperationId'

        attribute :name
        attribute :OperationId, :aliases => 'OperationId'
        attribute :ServerId, :aliases => 'ServerId'
        attribute :OperationType, :aliases => 'OperationType'
        attribute :OperationLabel, :aliases => 'OperationLabel'
        attribute :dateStart, :aliases => 'dateStart'
        attribute :dateEnd, :aliases => 'dateEnd'
        #attribute :OperationParameters, :aliases => 'OperationParameters'
        attribute :frequencyType, :aliases => 'frequencyType'
        attribute :ScheduleDaysOfMonth, :aliases => ':ScheduleDaysOfMonth'
        attribute :monthlyRecurrence, :aliases => 'monthlyRecurrence'
        attribute :ScheduleWeekDays, :aliases => 'ScheduleWeekDays'
        attribute :daysOfMonth, :aliases => 'daysOfMonth'
        attribute :daysOfWeek, :aliases => 'daysOfWeek'
        attribute :frequency, :aliases => 'frequency'

        ignore_attributes :OperationParameters

        def initialize
          @service = attributes[:service]
        end # initialize

        def get_scheduled_operations
          requires :dateStart, :dateEnd
          response = service.get_scheduled_operations
          new_attributes = response
          merge_attributes(new_attributes)
        end # get_schedule

        def create_scheduled_operation
          requires :dateStart, :dateEnd, :OperationType, :ServerId
          data = attributes
          service.create_scheduled_operation(data)
        end # create_schedule_operation

        def create_scheduled_occurrence
          requires :ServerId, :OperationType, :OperationLabel, :dateStart, :dateEnd, :frequencyType, :monthlyRecurrence, :daysOfMonth, :daysOfWeek, :frequency
          if :name != nil
            data[:name] = name
          else
            raise Fog::ArubaCloud::Errors::BadParameters.Exception('Missing Parameter')
          end
        end

        def suspend_scheduled_operation
          requires :id
          data = :attributes
          if :OperationId != nil
            data[:OperationId] = id
          else
            raise Fog::ArubaCloud::Errors::BadParameters.Exception('Missing Parameter')
          end
        end # suspend_scheduled_operation

        def delete_scheduled_operation
          requires :operationid
          data = :attributes
          if :OperationId != nil
            data[:OperationId] = operationid
          else
            raise Fog::ArubaCloud::Errors::BadParameters.Exception('Missing Parameter')
          end
        end # delete_scheduled_operation

      end # Schedule
    end # ArubaCloud
  end # Compute
end # Fog