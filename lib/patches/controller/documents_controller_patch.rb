module Pwfmt::DocumentsControllerPatch
  extend ActiveSupport::Concern

  included do
    before_render :load_wiki_format, only: [:edit, :show]
    before_render :load_all_documents_wiki_format, only: [:index]
    before_render :reserve_format, only: [:edit]
  end

  private

  def load_wiki_format
    @document.load_wiki_format! if @document.respond_to?(:load_wiki_format!)
  end

  def load_all_documents_wiki_format
    @project.documents.each(&:load_wiki_format!)
  end

  def reserve_format
    Pwfmt::Context.reserve_format('document_description', @document.description) if @document.respond_to?(:description)
  end
end

require 'documents_controller'
DocumentsController.__send__(:include, Pwfmt::DocumentsControllerPatch)

