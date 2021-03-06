module Ar
  class ProfilesController < ApplicationController
    before_action :set_profile, only: [:show, :edit, :update, :remove]

    # GET /profiles
    def index
      @profiles = profile_finder.all
      respond_with(@profiles)
    end

    # GET /profiles/1
    def show
      respond_with(@profile)
    end

    # GET /profiles/new
    def new
      @profile = Ar::Entities::Profile.new
      all_roles
    end

    # GET /profiles/1/edit
    def edit
      all_roles
    end

    # POST /profiles
    def create
      profile_creator.create({profile: profile_params}, {
        success: -> (profile) {
          redirect_to profile_path(profile.id), notice: I18n.t('flash.actions.create_profile.notice')
        },
        fail: -> (error) {
          @profile = Ar::Entities::Profile.new(profile_params)
          @error = error
          all_roles
          render :new
        }
      })
    end

    # PATCH/PUT /profiles/1
    def update
      profile_updater.update({profile: profile_params}, {
        success: -> (profile) {
          redirect_to profile_path(profile.id), notice: I18n.t('flash.actions.update_profile.notice')
        },
        fail: -> (error) {
          @profile = Ar::Entities::Profile.new(profile_params)
          @error = error
          all_roles
          render :edit
        }
      })
    end

    # DELETE /profiles/1
    def remove
      profile_remover.remove({profile: @profile}, {
        success: -> (profile) {
          redirect_to profiles_path, notice: I18n.t('flash.actions.remove_profile.notice')
        },
        fail: -> (error) {
          redirect_to profiles_path, notice: I18n.t('flash.actions.remove_profile.alert')
        }
      })

    end

    private

    def profile_creator
      @profile_creator ||= Ar::Services::Profiles::ProfileManagerCreator.new
    end

    def profile_updater
      @profile_updater ||= Ar::Services::Profiles::ProfileManagerUpdater.new
    end

    def profile_remover
      @profile_remover ||= Ar::Services::Profiles::ProfileManagerRemover.new
    end

    def profile_finder
      @profile_finder ||= Ar::Repositories::Profiles::Finder.new
    end

    def role_finder
      @role_finder ||= Ar::Repositories::Roles::Finder.new
    end

    def all_roles
      @roles = role_finder.all
    end

    def set_profile
      @profile = profile_finder.find(params[:id])
    end

    def profile_params
      params.require(:profile).
        permit(:id, :name, :description, role_ids: [])
    end

  end
end
