#
# Author:: Dangleterre Michaël
# © Copyright ArubaCloud.
#
# LICENSE: MIT (http://opensource.org/licenses/MIT)
#

require 'fog/core/model'
require 'fog/arubacloud/error'


module Fog
  module ArubaCloud
    class Compute
      class Custom_Template < Fog::Model
        identity :id,  :aliases => 'id'

        attribute :appliancetypeid, :aliases => 'appliancetypeid'
        attribute :architecturetypeid, :aliases => 'architecturetypeid'
        attribute :osfamilyid, :aliases => 'osfamilyid'
        attribute :osversion, :aliases => 'osversion'
        attribute :revision, :aliases => 'revision'
        attribute :defaultvalue, :aliases => 'defaultvalue'
        attribute :maxvalue, :aliases => 'maxvalue'
        attribute :minvalue, :aliases => 'minvalue'
        attribute :resourcetype, :aliases => 'resourcetype'
        attribute :templateboundid, :aliases => 'templateboundid'
        attribute :templatedescription, :aliases => 'templatedescription'
        attribute :templateexternaldescription, :aliases => 'templateexternaldescription'
        attribute :templatepassword, :aliases => 'templatepassword'
        attribute :templateusername, :aliases => 'templateusername'
        attribute :virtualmachineid, :aliases => 'virtualmachineid'

        def initialize(attributes = {})
          @service = attributes[:service]
        end # initialize

        def create
          requires :appliancetypeid, :architecturetypeid, :osfamilyid, :osversion, :revision, :defaultvalue, :maxvalue, :minvalue, :resourcetype, :templateboundid,:templatedescription, :templateexternaldescription, :templatepassword, :templateusername, :virtualmachineid
          data = :attributes
          service.create_custom_template(data)
        end # create

        def edit
          requires :appliancetypeid, :architecturetypeid, :osfamilyid, :osversion, :revision, :defaultvalue, :maxvalue, :minvalue, :resourcetype, :templateboundid,:templatedescription, :templateexternaldescription, :templatepassword, :templateusername, :virtualmachineid
          data = :attributes
          service.edit_custom_template(data)
        end # edit

        def delete
          requires :id
          data = :attributes
          service.delete_custom_template(data)
        end # delete

      end # Custom_Template
    end # ArubaCloud
  end # Compute
end # Fog