module Pwfmt
  module Patches
    module Controller
      # This patch extends WikiController.
      # This patch enables to load and save user selected format of wiki content.
      module WikiControllerPatch
        extend ActiveSupport::Concern

        included do
          before_render :load_wiki_format, only: %i[edit show]
          before_render :reserve_format, only: :edit
          before_render :set_wiki_format_for_preview, only: :preview
        end

        private

        # load wiki format of itself from database
        def load_wiki_format
          @content.load_wiki_format! if @content.respond_to?(:load_wiki_format!)
        end

        # set wiki format of itself for preview from request
        def set_wiki_format_for_preview
          @text.wiki_format = params[:pwfmt_format] if @text && params[:pwfmt_format]
        end

        # store wiki format of itself to database
        def reserve_format
          return unless @text && @content

          @text.wiki_format = @content.text.wiki_format
          Pwfmt::Context.reserve_format('content_text', @text)
        end
      end
    end
  end
end

require 'wiki_controller'
WikiController.__send__(:include, Pwfmt::Patches::Controller::WikiControllerPatch)
