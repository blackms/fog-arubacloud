#
# Author:: Alessio Rocchi (<alessio.rocchi@staff.aruba.it>)
# © Copyright ArubaCloud.
#
# LICENSE: MIT (http://opensource.org/licenses/MIT)
#

require 'fog/compute/models/server'
require 'fog/arubacloud/error'

module Fog
  module Compute
    class ArubaCloud
      # noinspection RubyTooManyMethodsInspection
      class Server < Fog::Compute::Server
        CREATING = 1
        STOPPED = 2
        RUNNING = 3
        ARCHIVED = 4
        DELETED = 5

        #collection_name :servers

        # This is the instance ID which is unique per Datacenter
        identity :id, :aliases => 'ServerId'

        attribute :name, :aliases => 'Name'
        attribute :state, :aliases => 'ServerStatus'
        attribute :memory, :aliases => 'RAMQuantity', :squash => 'Quantity'
        attribute :cpu, :aliases => 'CPUQuantity', :squash => 'Quantity'
        attribute :hypervisor, :aliases => 'HypervisorType'
        attribute :datacenter_id, :aliases => 'DatacenterId'
        attribute :hd_qty, :aliases => 'HDQuantity'
        attribute :hd_total_size, :aliases => 'HDTotalSize'
        attribute :smart_ipv4, :aliases => 'EasyCloudIPAddress', :squash => 'Value'
        attribute :smart_package, :aliases => 'EasyCloudPackageID'
        attribute :vnc_port, :aliases => 'VncPort'
        attribute :admin_passwd
        attribute :vm_type
        attribute :ipv4_addr
        attribute :package_id
        attribute :template_id, :aliases => 'OSTemplateId'
        attribute :template_description, :aliases => 'OSTemplate', :squash => :Description

        #has_many :network_adapters, :network_adapters, aliases: 'NetworkAdapters'

        ignore_attributes :CompanyId, :Parameters, :VirtualDVDs, :RenewDateSmart, :Note, :CreationDate,
                          :ControlToolActivationDate, :ControlToolInstalled, :UserId, :ScheduledOperations, :Snapshots,
                          :ActiveJobs

        def initialize(attributes = {})
          @service = attributes[:service]

          if attributes[:vm_type].nil?
            self.vm_type = 'smart' if attributes['HypervisorType'].eql? '4'
          else
            'pro'
          end

          super
        end

        def action_hook(method, required_attr, expected_state, message)
          if @service.respond_to? method
            required_attr.each { |r| requires r }
            unless state.eql? expected_state
              raise Fog::ArubaCloud::Errors::VmStatus.new(message)
            end
            @service.send method, id
          end
        end

        # Is server in ready state
        # @param [String] ready_state By default state is RUNNING
        # @return [Boolean] return true if server is in ready state
        def ready?(ready_state=RUNNING)
          state == ready_state
        end

        # Is server in stopped state
        # @param [String] stopped_state By default stopped state is STOPPED
        # @return [Boolean] return true if server is in stopped state
        def stopped?(stopped_state=STOPPED)
          state == stopped_state
        end

        # Is server in creating state
        # @param [String] creating_state By default creating state is CREATING
        # @return [Boolean] return true if server is in creating state
        def creating?(creating_state=CREATING)
          state == creating_state
        end

        def save
          if persisted?
            update
          else
            create
          end
        end

        def create
          requires :name, :cpu, :memory, :admin_passwd, :vm_type
          data = attributes

          if vm_type.eql? 'pro'
            # Automatically purchase a public ip address
            data[:ipv4_id] = service.purchase_ip['Value']['ResourceId']
            service.create_vm_pro(data)
          elsif vm_type.eql? 'smart'
            service.create_vm_smart(data)
          else
            raise Fog::ArubaCloud::Errors::BadParameters.new('VM Type can be smart or pro.')
          end

          # Retrieve new server list and filter the current virtual machine
          # in order to retrieve the ID
          server = nil
          while server.nil?
            servers = service.get_servers
            servers['Value'].each do |s|
              server = s if s['Name'].to_s.include? data[:name].to_s
            end
          end
          Fog::Logger.debug("Fog::Compute::ArubaCloud::Server.create, #{data[:name]} server: #{server.inspect}")
          if server
            merge_attributes(server)
          else
            message = 'error during attribute merge, `server` object is not ready.'
            Fog::Logger.warning("Fog::Compute::ArubaCloud::Server.create, #{message}")
            sleep(1)
          end
        end

        def get_server_details
          requires :id
          response = service.get_server_details(id)
          new_attributes = response['Value']
          merge_attributes(new_attributes)
        end

        def get_public_ip
          requires :id
          if self.vm_type.eql? 'smart'
            self.smart_ipv4
          else
            self.get_server_details unless self.attributes['NetworkAdapters']
            self.attributes['NetworkAdapters'].each do |na|
              na['IPAddresses'].each do |ipa|
                if ipa['ProductId'].eql? 20
                  self.ipv4_addr = ipa['Value'].to_s
                  return self.ipv4_addr
                end
              end
            end
          end

        end

        def power_off
          self.action_hook(
              :power_off_vm,
              [:id, :state],
              RUNNING,
              "Cannot poweroff vm in current state: #{state}"
          )
        end

        def power_on
          self.action_hook(
              power_on_vm,
              [:id, :state],
              STOPPED,
              "Cannot poweron vm in current state: #{state}"
          )
        end

        def delete
          requires :id
          state == STOPPED ? service.delete_vm(id) : raise(Fog::ArubaCloud::Errors::VmStatus.new(
              "Cannot delete vm in current state: #{state}"
          ))
        end

        def reinitialize
          requires :id, :hypervisor
          state == STOPPED ? service.reinitialize_vm(id) : raise(Fog::ArubaCloud::Errors::VmStatus.new(
              "Cannot reinitialize vm in current state: #{state}"
          ))
        end

        def archive
          requires :id, :state, :vm_type
          if state == STOPPED and vm_type.eql?('pro')
            service.archive_vm(id)
          else
            raise(Fog::ArubaCloud::Errors::VmStatus.new(
                "Cannot archive VM in current state #{state} or VM type #{vm_type}"))
          end
        end

        def restore
          requires :id, :memory, :cpu
          state == ARCHIVED and memory != nil and cpu != nil ? service.restore_vm(id) : raise(
              Fog::ArubaCloud::Errors::VmStatus.new("Cannot restore VM without specifying #{cpu} and #{memory}"
              ))
        end

        def create_snapshot
          requires :id
          id != nil ? service.create_snapshot(id) : raise(Fog::ArubaCloud::Errors::VmStatus.new(
              'Cannot crate snapshot without vm id'
          ))
        end

        def apply_snapshot
          requires :id
          state == STOPPED ? service.apply_snapshot(id) : raise(Fog::ArubaCloud::Errors::VmStatus.new(
              "Cannot restore snapshot in current vm state #{state}"
          ))
        end

        def delete_snapshot
          requires :id
          service.delete_snapshot(id)
        end
      end
    end
  end
end