module Pwfmt::DocumentsControllerPatch
  extend ActiveSupport::Concern

  included do
    before_filter :load_wiki_format
    before_filter :reserve_format, only: [:edit]
  end

  private

  def load_wiki_format
    if defined?(@document)
      @document.load_wiki_format!
    elsif defined?(@project)
      @project.documents.each(&:load_wiki_format!)
    end
  end

  def reserve_format
    Pwfmt::Context.reserved_format = @document.description.pwfmt.format if @document.description.try(:pwfmt)
  end
end

require 'documents_controller'
DocumentsController.send(:include, Pwfmt::DocumentsControllerPatch)
