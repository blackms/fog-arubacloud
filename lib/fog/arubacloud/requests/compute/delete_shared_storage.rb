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
        def delete_shared_storage(data)
          body = self.body('SetEnqueueRemoveSharedStorage').merge(
              {
                  :SharedStorage => {
                      :storageId => data[:id]
                  }
              }
          )
          options = {
              :http_method => :post,
              :method => 'SetEnqueueRemoveSharedStorage',
              :body => Fog::JSON.encode(body)
          }
          response = nil
          time = Benchmark.realtime {
            response = request(options)
          }
          Fog::Logger.debug("SetEnqueueRemoveSharedStorage time: #{time}")
          if response['Success']
            response
          else
            raise Fog::ArubaCloud::Errors::RequestError.new('Error in request.')
          end

        end # edit_shared_storage
        class Mock
          def edit_shared_storage
            raise Fog::Errors::MockNotImplemented.new(
                      'Mock not implemented. Feel free to contribute.'
                  )
          end # edit_shared_storage
        end # Mock
      end # Real
    end # ArubaCloud
  end # Compute
end # Fog