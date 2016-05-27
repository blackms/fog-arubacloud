#
# Author:: Dangleterre Michaël
# © Copyright ArubaCloud.
#
# LICENSE: MIT (http://opensource.org/licenses/MIT)
#

require 'fog/core/model'
require 'fog/arubacloud/error'


module Fog
  module Compute
    class ArubaCloud
      class SharedStorage < Fog::Model
        identity :id, :aliases => 'id'

        attribute :quantity, :aliases => 'quantity'
        attribute :value, :aliases => 'value'
        attribute :sharedstoragename, :aliases => 'sharedstoragename'
        attribute :sharedstorageprotocoltype

        def initialize(attributes = {})
          @service = attributes[:service]
        end

        def create
          requires :sharedstorageprotocoltype, :quantity, :sharedstoragename
          if :sharedstorageprotocoltype == 'ISCSI'
            requires :value
          end
          data = :attributes
          service.create_shared_storage(data)
        end # create

        def edit
          requires :id
          data = :attributes
          service.edit_shared_storage(data)
        end # edit

        def delete
          requires :id
          data = :attributes
          service.delete_shared_storage(data)
        end # delete

        def rename
          requires :id, :sharedstoragename
          data = :attributes
          service.rename_shared_storage(data)
        end # rename

      end # Custom_Template
    end # ArubaCloud
  end # Compute
end # Fog