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
        def rename_shared_storage(data)
          body = self.body('SetRenameSharedStorage').merge(
              {
                  :SharedStorage => {
                      :SharedStorageId => data[:id],
                      :SharedStorageName => data[:sharedstoragename]
                  }
              }
          )
          options = {
              :http_method => :post,
              :method => 'SetRenameSharedStorage',
              :body => Fog::JSON.encode(body)
          }
          response = nil
          time = Benchmark.realtime {
            response = request(options)
          }
          Fog::Logger.debug("SetRenameSharedStorage time: #{time}")
          if response['Success']
            response
          else
            raise Fog::ArubaCloud::Errors::RequestError.new('Error in request.')
          end

        end # rename_shared_storage
        class Mock
          def rename_shared_storage
            raise Fog::Errors::MockNotImplemented.new(
                      'Mock not implemented. Feel free to contribute.'
                  )
          end # rename_shared_storage
        end # Mock
      end # Real
    end # ArubaCloud
  end # Compute
end # Fog