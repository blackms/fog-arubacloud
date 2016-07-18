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
        def create_shared_storage(data)
          body = {
              :SharedStorage => {
                  :Quantity => data[:quantity],
                  :SharedStorageName => data[:sharedstoragename],
                  :SharedStorageProtocolType => data[:sharedstorageprotocoltype],
              }
          }
          unless data[:sharedstorageprotocoltype].include? 'ISCSI'
            body[:SharedStorage] << {
                :Value => data[:Value]
            }
          end
          self.request(
              body,
              'SetEnqueuePurchaseSharedStorage',
              'Error during Shared Storage creation.'
          )
        end
      end # Real

      class Mock
        def create_shared_storage(data)
          response = Excon::Response.new
          response.status = 200
          response.body = {
              'ExceptionInfo' => nil,
              'ResultCode' => 0,
              'ResultMessage' => nil,
              'Success' => true
          }
          response.body
        end # create_shared_storage
      end # Mock

    end # ArubaCloud
  end # Compute
end # Fog