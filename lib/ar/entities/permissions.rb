module Ar
  module Entities
    class Permissions

      attr_reader :permissions

      def initialize(resources)
        @resources   = resources
        @permissions = Array.new
        build_permissions
      end

      def has_permission?(resource_name, action_name)
        hash_permission = build_hash_permission(resource_name, action_name)
        permissions.include?(hash_permission)
      end

      private
      def build_permissions
        @resources.each do |resource|
          resource.actions.collect do |action|
            hash_permission = build_hash_permission(resource.name, action.name)
            @permissions << hash_permission unless permissions.include?(hash_permission)
          end
        end
      end

      def build_hash_permission(resource_name, action_name)
        {'resource' => resource_name, 'action' => action_name }
      end

    end
  end
end

