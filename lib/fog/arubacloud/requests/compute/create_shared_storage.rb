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
  module Compute
    class ArubaCloud
      class Real
        def create_shared_storage(data)
          body = self.body('SetEnqueuePurchaseSharedStorage').merge(
              {
                  :SharedStorage => {
                      :Quantity => data[:quantity],
                      :SharedStorageName => data[:sharedstoragename],
                      :SharedStorageProtocolType => data[:sharedstorageprotocoltype],
                  }
              }
          )
          unless data[:sharedstorageprotocoltype].include? 'ISCSI'
            body[:SharedStorage] << {
                :Value => data[:Value]
            }
          end
          options = {
              :http_method => :post,
              :method => 'SetEnqueuePurchaseSharedStorage',
              :body => Fog::JSON.encode(body)
          }
          response = nil
          time = Benchmark.realtime {
            response = request(options)
          }
          Fog::Logger.debug("SetEnqueuePurchaseSharedStorage time: #{time}")
          if response['Success']
            response
          else
            raise Fog::ArubaCloud::Errors::RequestError.new('Error in request.')
          end

        end # create_shared_storage
        class Mock
          def create_shared_storage
            raise Fog::Errors::MockNotImplemented.new(
                      'Mock not implemented. Feel free to contribute.'
                  )
          end # create_shared_storage
        end # Mock
      end # Real
    end # ArubaCloud
  end # Compute
end # Fog