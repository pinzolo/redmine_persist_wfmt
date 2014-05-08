module Pwfmt::ApplicationHelperPatch
  extend ActiveSupport::Concern

  included do
    alias_method_chain :textilizable, :pwfmt
  end

  def textilizable_with_pwfmt(*args)
    args.first.load_wiki_format! if args.first.respond_to?(:load_wiki_format!)
    textilizable_without_pwfmt(*args)
  end
end

require 'application_helper'
ApplicationHelper.send(:include, Pwfmt::ApplicationHelperPatch)
