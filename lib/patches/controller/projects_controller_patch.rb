# This patch extends ProjectsController.
# This patch enables to load and save user selected format of project description.
module Pwfmt::ProjectsControllerPatch
  extend ActiveSupport::Concern

  included do
    before_render :load_wiki_format, only: %i(edit settings show)
    before_render :reserve_format, only: %i(edit settings)
  end

  private

  # load wiki format of itself from database
  def load_wiki_format
    @project.load_wiki_format! if @project.respond_to?(:load_wiki_format!)
  end

  # store wiki format of itself to database
  def reserve_format
    Pwfmt::Context.reserve_format('project_description', @project.description) if @project.respond_to?(:description)
  end
end

require 'projects_controller'
ProjectsController.__send__(:include, Pwfmt::ProjectsControllerPatch)
