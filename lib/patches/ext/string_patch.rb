module Pwfmt::StringPatch
  attr_accessor :wiki_format
end

String.__send__(:include, Pwfmt::StringPatch)
