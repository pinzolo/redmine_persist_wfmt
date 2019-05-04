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
    pwfmts = PwfmtFormat.where(target_id: @project.documents.map(&:id), field: 'document_description')
    formats = Hash[pwfmts.map { |f| [f.target_id, f.format] }]
    @grouped.values.each do |docs|
      docs.each do |doc|
        doc.description.wiki_format = formats[doc.id] if formats[doc.id]
      end
    end
  end

  def reserve_format
    Pwfmt::Context.reserve_format('document_description', @document.description) if @document.respond_to?(:description)
  end
end

require 'documents_controller'
DocumentsController.__send__(:include, Pwfmt::DocumentsControllerPatch)

