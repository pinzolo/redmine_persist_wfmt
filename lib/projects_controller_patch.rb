module Pwfmt::ProjectsControllerPatch
  extend ActiveSupport::Concern

  included do
    before_filter :load_wiki_format
  end

  private

  def load_wiki_format
    @project.load_wiki_format! if defined?(@project)
  end
end

require "projects_controller"
ProjectsController.send(:include, Pwfmt::ProjectsControllerPatch)

