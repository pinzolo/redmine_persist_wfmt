# This patch extends DocumentsController.
# This patch enables to load and save user selected format of document description.
module Pwfmt::DocumentsControllerPatch
  extend ActiveSupport::Concern

  included do
    before_render :load_wiki_format, only: %i[edit show]
    before_render :load_all_documents_wiki_format, only: :index
    before_render :reserve_format, only: :edit
  end

  private

  # load wiki format of itself from database
  def load_wiki_format
    @document.load_wiki_format! if @document.respond_to?(:load_wiki_format!)
  end

  # load all documents' wiki format
  def load_all_documents_wiki_format
    pwfmts = PwfmtFormat.where(target_id: @project.documents.map(&:id), field: 'document_description')
    formats = Hash[pwfmts.map { |f| [f.target_id, f.format] }]
    @grouped.values.each do |docs|
      docs.each do |doc|
        doc.description.wiki_format = formats[doc.id] if formats[doc.id]
      end
    end
  end

  # store wiki format of itself to database
  def reserve_format
    Pwfmt::Context.reserve_format('document_description', @document.description) if @document.respond_to?(:description)
  end
end

require 'documents_controller'
DocumentsController.__send__(:include, Pwfmt::DocumentsControllerPatch)
