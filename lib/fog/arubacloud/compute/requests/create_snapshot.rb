#
# Author:: Dangleterre Michaël
# © Copyright ArubaCloud.
#
# LICENSE: MIT (http://opensource.org/licenses/MIT)
#

require 'fog/arubacloud/service'
require 'fog/arubacloud/error'
require 'benchmark'


module Fog
  module ArubaCloud
    class Compute

      class Real
        # Create a new snapshot of a VM
        def create_snapshot(data)
          (service.servers).all.each do |server|
            id = server.id if (server.name).include? data[:name]
          end
          body = {
                  :Snapshot => {
                      :ServerId => id,
                      :SnapshotOperationTypes => 'Create'
                  }
              }
          self.request(
                  body=body,
                  method_name='SetEnqueueServerSnapshot',
                  failure_message='Error while attempting to create a snapshot.'
          )
        end #Create_snapshot
      end #Real

      class Mock
        def create_snapshot
          response = Excon::Response.new
          response.status = 200
          response.body = {
              'ExceptionInfo' => nil,
              'ResultCode' => 0,
              'ResultMessage' => nil,
              'Success' => true
          }
          response.body
        end
      end
    end #ArubaCloud
  end #Compute
end #Fog