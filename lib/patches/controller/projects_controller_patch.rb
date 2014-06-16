module Pwfmt::ProjectsControllerPatch
  extend ActiveSupport::Concern

  included do
    before_render :load_wiki_format, only: [:edit, :settings, :show]
    before_render :reserve_format, only: [:edit, :settings, :show]
  end

  private

  def load_wiki_format
    @project.load_wiki_format! if @project.respond_to?(:load_wiki_format!)
  end

  def reserve_format
    Pwfmt::Context.reserve_format('project_description', @project.description)
  end
end

require "projects_controller"
ProjectsController.send(:include, Pwfmt::ProjectsControllerPatch)
