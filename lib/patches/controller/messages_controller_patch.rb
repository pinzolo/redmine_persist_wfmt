module Pwfmt::MessagesControllerPatch
  extend ActiveSupport::Concern

  included do
    before_render :load_wiki_format, only: [:edit, :show]
    before_render :reserve_format, only: [:edit]
    before_render :set_wiki_format_for_preview, only: [:preview]
  end

  private

  def load_wiki_format
    @message.load_wiki_format! if @message.respond_to?(:load_wiki_format!)
    @replies.each(&:load_wiki_format!) if @replies
  end

  def set_wiki_format_for_preview
    @text.wiki_format = params[:pwfmt_format] if @text && params[:pwfmt_format]
  end

  def reserve_format
    Pwfmt::Context.reserve_format('message_content', @message.content) if @message.respond_to?(:content)
  end
end

require 'messages_controller'
MessagesController.__send__(:include, Pwfmt::MessagesControllerPatch)
