module Pwfmt::MessagesControllerPatch
  extend ActiveSupport::Concern

  included do
    before_filter :load_wiki_format
    before_filter :reserve_format, only: [:edit]
  end

  private

  def load_wiki_format
    @message.load_wiki_format! if defined?(@message)
  end

  def reserve_format
    Pwfmt::Context.reserved_format = @message.content.pwfmt.format if @message.content.try(:pwfmt)
  end
end

require 'messages_controller'
MessagesController.send(:include, Pwfmt::MessagesControllerPatch)
