# This patch extends ApplicationHelper.
module Pwfmt::ApplicationHelperPatch
  # truncate_lines returns new string instance, so need to reset wiki fortmat.
  def truncate_lines(string, options={})
    fmt = string.wiki_format
    super(string, options).tap do |s|
      Rails.logger.debug("pwfmt: #{fmt}")
      s.wiki_format = fmt if fmt
    end
  end
end

require 'application_helper'
ApplicationHelper.prepend(Pwfmt::ApplicationHelperPatch)
