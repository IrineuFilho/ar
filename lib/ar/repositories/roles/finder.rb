module Ar
  module Repositories
    module Roles
      class Finder
        include Ar::Repositories::Base

        def find(id)
          record = repository_class.find(id)
          mapper_instance.map_to_entity(record)
        end

        def all
          repository_class.all.collect do |record|
            mapper_instance.map_to_entity(record)
          end
        end

        def mapper_instance
          Ar::DataMappers::RoleMapper.instance
        end

        def repository_class
          RepositoryRole
        end

      end
    end
  end
end
