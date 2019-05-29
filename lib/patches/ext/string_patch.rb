module Pwfmt
  # This patch extends String for setting self format.
  module StringPatch
    # wiki format for itself
    attr_accessor :wiki_format
  end
end

String.__send__(:include, Pwfmt::StringPatch)
