# PwfmtFormat controls 'pwfmt_format' table.
class PwfmtFormat < ActiveRecord::Base
  def self.persist(target, field, wiki_format=nil)
    format = wiki_format || Pwfmt::Context.format_for(field)
    return unless Redmine::WikiFormatting.format_names.include?(format)

    pwfmt = PwfmtFormat.where(target_id: target.id, field: field).first
    if pwfmt
      pwfmt.update(format: format)
    else
      PwfmtFormat.create(target_id: target.id, field: field, format: format)
    end
  end

  def self.persist_all_as(format)
    Project.find_each do |project|
      PwfmtFormat.persist(project, 'project_description', format) if project.description.present?
    end
    Issue.find_each do |issue|
      PwfmtFormat.persist(issue, 'issue_description', format) if issue.description.present?
    end
    Journal.find_each do |journal|
      PwfmtFormat.persist(journal, 'journal_notes', format) if journal.notes.present?
    end
    Document.find_each do |document|
      PwfmtFormat.persist(document, 'document_description', format) if document.description.present?
    end
    News.find_each do |news|
      PwfmtFormat.persist(news, 'news_description', format) if news.description.present?
    end
    Message.find_each do |message|
      PwfmtFormat.persist(message, 'message_content', format) if message.content.present?
    end
    Comment.find_each do |comment|
      PwfmtFormat.persist(comment, 'comment_comments', format) if comment.comments.present?
    end
    WikiContent.find_each do |wiki_content|
      wiki_content.versions.find_each do |version|
        PwfmtFormat.persist(wiki_content, "wiki_content:v#{version.version}", format)
      end
    end
    welcome_text_setting = Setting.where(name: 'welcome_text').first
    if welcome_text_setting && welcome_text_setting.value.present?
      PwfmtFormat.persist(Setting.where(name: 'welcome_text').first, 'settings_welcome_text', format)
    end
  end
end
