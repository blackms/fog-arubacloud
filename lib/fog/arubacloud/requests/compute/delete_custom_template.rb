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
        def delete_custom_template(data)
          body = {
              :template => {
                  :templateID => data[:id]
              }
          }
          self.request(
                  body=body,
                  method_name='SetRemovePersonalTemplate',
                  failure_message='Error while attempting to delete custom template.'
          )
        end # delete_custom_template
      end # Real

      class Mock
        def delete_custom_template
          raise Fog::Errors::MockNotImplemented.new(
              'Mock not implemented. Feel free to contribute.'
          )
        end # delete_custom_template
      end # Mock

    end # ArubaCloud
  end # Compute
end # Fog