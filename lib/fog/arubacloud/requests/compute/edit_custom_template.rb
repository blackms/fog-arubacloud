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
          body = {
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
          }
          self.request(
                  body,
                  'SetUpdatePersonalTemplate',
                  'Error while editing custom template.'
          )
        end # edit_custom_template
      end # Real

      class Mock
        def edit_custom_template
          raise Fog::Errors::MockNotImplemented.new(
              'Mock not implemented. Feel free to contribute.'
          )
        end # edit_custom_template
      end # Mock

    end # ArubaCloud
  end # Compute
end # Fog