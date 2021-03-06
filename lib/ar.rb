require "ar/version"
require "rails/railtie"

# Additions
require "ar/additions/resource"

# Exceptions
require "ar/exceptions/record_invalid"

# Entities
require "ar/entities/resource"
require "ar/entities/action"
require "ar/entities/role"
require "ar/entities/profile"
require "ar/entities/permissions"

# Mappers
require "ar/data_mappers/base"
require "ar/data_mappers/resource_mapper"
require "ar/data_mappers/action_mapper"
require "ar/data_mappers/role_mapper"
require "ar/data_mappers/profile_mapper"

# Validators
require "ar/validators/resource_validator"
require "ar/validators/action_validator"
require "ar/validators/role_validator"
require "ar/validators/profile_validator"

# Repositories
require "ar/repositories/base"
require "ar/repositories/registrator"

require "ar/repositories/resources/repository_resource"
require "ar/repositories/resources/finder"
require "ar/repositories/resources/remover"
require "ar/repositories/resources/creator"

require "ar/repositories/actions/repository_action"
require "ar/repositories/actions/finder"
require "ar/repositories/actions/remover"
require "ar/repositories/actions/creator"

require "ar/repositories/roles/repository_role"
require "ar/repositories/roles/finder"
require "ar/repositories/roles/creator"
require "ar/repositories/roles/updater"
require "ar/repositories/roles/remover"

require "ar/repositories/profiles/repository_profile"
require "ar/repositories/profiles/finder"
require "ar/repositories/profiles/creator"
require "ar/repositories/profiles/updater"
require "ar/repositories/profiles/remover"

# Services
require "ar/services/base"
require "ar/services/verifier"

require "ar/services/actions/create/action_creator"
require "ar/services/actions/remove/action_remover"

require "ar/services/resources/create/resource_creator"
require "ar/services/resources/remove/resource_remover"
require "ar/services/resources/resource_manager_creator"

require "ar/services/roles/role_manager_creator"
require "ar/services/roles/role_manager_updater"
require "ar/services/roles/role_manager_remover"
require "ar/services/roles/create/role_creator"
require "ar/services/roles/update/role_updater"
require "ar/services/roles/remove/role_remover"

require "ar/services/profiles/profile_manager_creator"
require "ar/services/profiles/profile_manager_updater"
require "ar/services/profiles/profile_manager_remover"
require "ar/services/profiles/create/profile_creator"
require "ar/services/profiles/update/profile_updater"
require "ar/services/profiles/remove/profile_remover"

module Ar

  class Railtie < ::Rails::Railtie
    initializer "ar.configure_view_controller" do |app|
      ActiveSupport.on_load :action_controller do
        include Ar::Additions::Resource
      end
    end
  end

end
