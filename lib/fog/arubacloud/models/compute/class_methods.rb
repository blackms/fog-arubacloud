module Fog
  module Compute
    module ArubaCloud
      module Models
        module ClassMethods

          def collection_name(collection_name=nil)
            return @collection_name if collection_name.nil?
            @collection_name = collection_name
          end

        end
      end
    end
  end
end
