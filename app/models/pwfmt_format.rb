# PwfmtFormat controls 'pwfmt_format' table.
class PwfmtFormat < ActiveRecord::Base
  class << self
    def persist(target, field, wiki_format = nil)
      format = wiki_format || Pwfmt::Context.format_for(field)
      return unless Redmine::WikiFormatting.format_names.include?(format)

      pwfmt = PwfmtFormat.where(target_id: target.id, field: field).first
      if pwfmt
        pwfmt.update(format: format)
      else
        PwfmtFormat.create(target_id: target.id, field: field, format: format)
      end
    end

    def persist_all_as(format)
      persist_all_projects_as(format)
      persist_all_issues_as(format)
      persist_all_journals_as(format)
      persist_all_documents_as(format)
      persist_all_news_as(format)
      persist_all_messagess_as(format)
      persist_all_comments_as(format)
      persist_all_wiki_as(format)
      persist_welcome_text_as(format)
    end

    private

    def persist_all_projects_as(format)
      Project.find_each do |project|
        PwfmtFormat.persist(project, 'project_description', format) if project.description.present?
      end
    end

    def persist_all_issues_as(format)
      Issue.find_each do |issue|
        PwfmtFormat.persist(issue, 'issue_description', format) if issue.description.present?
      end
    end

    def persist_all_journals_as(format)
      Journal.find_each do |journal|
        PwfmtFormat.persist(journal, 'journal_notes', format) if journal.notes.present?
      end
    end

    def persist_all_documents_as(format)
      Document.find_each do |document|
        PwfmtFormat.persist(document, 'document_description', format) if document.description.present?
      end
    end

    def persist_all_news_as(format)
      News.find_each do |news|
        PwfmtFormat.persist(news, 'news_description', format) if news.description.present?
      end
    end

    def persist_all_messagess_as(format)
      Message.find_each do |message|
        PwfmtFormat.persist(message, 'message_content', format) if message.content.present?
      end
    end

    def persist_all_comments_as(format)
      Comment.find_each do |comment|
        PwfmtFormat.persist(comment, 'comment_comments', format) if comment.comments.present?
      end
    end

    def persist_all_wiki_as(format)
      WikiContent.find_each do |wiki_content|
        wiki_content.versions.find_each do |version|
          PwfmtFormat.persist(wiki_content, "wiki_content:v#{version.version}", format)
        end
      end
    end

    def persist_welcome_text_as(format)
      welcome_text_setting = Setting.where(name: 'welcome_text').first
      valid = welcome_text_setting && welcome_text_setting.value.present?
      PwfmtFormat.persist(Setting.where(name: 'welcome_text').first, 'settings_welcome_text', format) if valid
    end
  end
end
