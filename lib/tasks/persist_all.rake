namespace :pwfmt do
  desc "persist all formats"
  task persist_all: :environment do
    format = ENV['FORMAT']
    if format.nil? || !Redmine::WikiFormatting.format_names.include?(format.downcase)
      puts "format must be one of [#{Redmine::WikiFormatting.format_names.to_a.join(',')}]"
    else
      PwfmtFormat.persist_all_as(format)
    end
  end
end
