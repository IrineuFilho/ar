module Ar
  class ResourcesController < ApplicationController
    before_action :set_resource, only: [:show]

    # GET /resources
    def index
      @resources = resource_finder.all
      respond_with(@resources)
    end

    # GET /resources/1
    def show
      respond_with(@resource)
    end

    # GET /generate_resources_and_actions
    def generate_resources_and_actions
      Rails.application.eager_load!

      resource_creator.create({resourceables: ApplicationController.descendants}, {
        success: -> (resource) {
          flash[:notice] = I18n.t('flash.actions.generate_resources_and_actions.notice')
        },
        fail: -> (error) {
          flash[:alert] = I18n.t('flash.actions.generate_resources_and_actions.alert')
        }
      })

      redirect_to resources_path
    end

    private

    def resource_creator
      @resource_creator ||= Ar::Services::Resources::ResourceManagerCreator.new
    end

    def resource_finder
      @resource_finder ||= Ar::Repositories::Resources::Finder.new
    end

    def set_resource
      @resource = resource_finder.find(params[:id])
    end

  end
end
