module Pwfmt::MessagesControllerPatch
  extend ActiveSupport::Concern

  included do
    before_render :load_wiki_format, only: [:edit, :show]
    before_render :reserve_format, only: [:edit]
  end

  private

  def load_wiki_format
    @message.load_wiki_format! if @message.respond_to?(:load_wiki_format!)
  end

  def reserve_format
    Pwfmt::Context.reserve_format('message_content', @message.content) if @message.respond_to?(:content)
  end
end

require 'messages_controller'
MessagesController.send(:include, Pwfmt::MessagesControllerPatch)
