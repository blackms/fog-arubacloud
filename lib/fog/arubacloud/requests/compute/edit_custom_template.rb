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
        def edit_custom_template(data)
          body = self.body('SetUpdatePersonalTemplate').merge(
              :template => {
                  :ApplianceTypeID => data[:ApplianceTypeID],
                  :ArchitectureTypeID => data[:ArchitectureTypeID],
                  :OSFamilyID => data[:OSFamilyID],
                  :OSVersion => data[:OSVersion],
                  :Revision => data[:Revision],
                  :TemplateBound => [
                      :TemplateBound => [
                          {
                              :DefaultValue => data[:DefaultValue],
                              :MaxValue => data[:MaxValue],
                              :MinValue => data[:MinValue],
                              :ResourceType => data[:ResourceType],
                              :TemplateBoundID => data[:TemplateBoundID]
                          }
                      ]
                  ],
                  :TemplateDescription => data[:TemplateDescription],
                  :TemplateExternalDescription => data[:TemplateExternalDescription],
                  :TemplatePassword => data[:TemplatePassword],
                  :TemplateUsername => data[:TemplateUsername],
                  :VirtualMachineID => data[:VirtualMachineID]
              }
          )
          options = {
              :http_method => :post,
              :method => 'SetUpdatePersonalTemplate',
              :body => Fog::JSON.encode(body)
          }

          response = nil
          time = Benchmark.realtime {
            response = request(options)
          }
          Fog::Logger.debug("SetUpdatePersonalTemplate time: #{time}")
          if response['Success']
            response
          else
            raise Fog::ArubaCloud::Errors::RequestError.new('Error during the request.')
          end

        end # edit_custom_template
        class Mock
          def edit_custom_template
            raise Fog::Errors::MockNotImplemented.new(
                      'Mock not implemented. Feel free to contribute.'
                  )
          end # edit_custom_template
        end # Mock
      end # Real
    end # ArubaCloud
  end # Compute
end # Fog