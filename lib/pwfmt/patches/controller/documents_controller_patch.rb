module Pwfmt
  module Patches
    module Controller
      # This patch extends DocumentsController.
      # This patch enables to load and save user selected format of document description.
      module DocumentsControllerPatch
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
          formats = preload_formats
          @grouped.values.flatten.each do |doc|
            doc.description.wiki_format = formats[doc.id] if formats[doc.id]
          end
        end

        def preload_formats
          doc_ids = @project.documents.map(&:id)
          PwfmtFormat.where(target_id: doc_ids, field: 'document_description')
                    .pluck(:target_id, :format).to_h
        end

        # store wiki format of itself to database
        def reserve_format
          return unless @document.respond_to?(:description)

          Pwfmt::Context.reserve_format('document_description', @document.description)
        end
      end
    end
  end
end

require 'documents_controller'
DocumentsController.__send__(:include, Pwfmt::Patches::Controller::DocumentsControllerPatch)
