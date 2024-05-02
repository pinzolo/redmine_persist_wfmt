module Pwfmt
  module Patches
    module Ext
      # This patch extends Redmine::WikiFormatting module.
      module WikiFormattingPatch
        # render html with self format instead of setting.
        def to_html(format, text, options = {})
          if text.respond_to?(:wiki_format) && Redmine::WikiFormatting.format_names.include?(text.wiki_format)
            super(text.wiki_format, text, options)
          else
            super(format, text, options)
          end
        end
      end
    end
  end
end

Redmine::WikiFormatting.singleton_class.prepend(Pwfmt::Patches::Ext::WikiFormattingPatch)
