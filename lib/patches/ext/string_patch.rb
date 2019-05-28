# This patch extends String for setting self format.
module Pwfmt::StringPatch
  # wiki format for itself
  attr_accessor :wiki_format
end

String.__send__(:include, Pwfmt::StringPatch)
