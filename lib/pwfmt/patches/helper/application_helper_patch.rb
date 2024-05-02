module Pwfmt
  module Patches
    module Helper
      # This patch extends ApplicationHelper.
      module ApplicationHelperPatch
        # truncate_lines returns new string instance, so need to reset wiki fortmat.
        def truncate_lines(string, options = {})
          fmt = string.wiki_format
          super(string, options).tap do |s|
            s.wiki_format = fmt if fmt
          end
        end
      end
    end
  end
end

require 'application_helper'
ApplicationHelper.prepend(Pwfmt::Patches::Helper::ApplicationHelperPatch)
