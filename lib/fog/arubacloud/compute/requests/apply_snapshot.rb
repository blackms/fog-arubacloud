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
        # Apply a snapshot on a VM
        def apply_snapshot(data)
          (service.servers).all.each do |server|
            id = server.id if (server.name).include? data[:name]
          end
          body = {
              :Snapshot => {
                  :ServerId => id,
                  :SnapshotOperationTypes => 'Restore'
              }
          }
          self.request(
                  body=body,
                  method_name='SetEnqueueServerSnapshot',
                  failure_message='Error while applying snapshot.'
          )
        end #Apply
      end #Real
      class Mock
        def apply_snapshot
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
    end # ArubaCloud
  end # Compute
end # Fog