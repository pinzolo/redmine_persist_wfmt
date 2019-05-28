# This patch extends MessagesController.
# This patch enables to load and save user selected format of message content.
module Pwfmt::MessagesControllerPatch
  extend ActiveSupport::Concern

  included do
    before_render :load_wiki_format, only: %i[edit show]
    before_render :reserve_format, only: :edit
    before_render :set_wiki_format_for_preview, only: :preview
  end

  private

  # load wiki format of itself from database
  def load_wiki_format
    @message.load_wiki_format! if @message.respond_to?(:load_wiki_format!)
    @replies&.each(&:load_wiki_format!)
  end

  # set wiki format of itself for preview from request
  def set_wiki_format_for_preview
    @text.wiki_format = params[:pwfmt_format] if @text && params[:pwfmt_format]
  end

  # store wiki format of itself to database
  def reserve_format
    Pwfmt::Context.reserve_format('message_content', @message.content) if @message.respond_to?(:content)
  end
end

require 'messages_controller'
MessagesController.__send__(:include, Pwfmt::MessagesControllerPatch)
