require_relative '../spec_helper'

describe PwfmtFormat do
  describe '.persist' do
    fixtures :documents
    let(:doc) { Document.all.first }
    let(:field) { 'document_description' }

    shared_examples_for 'format persistence' do
      subject { PwfmtFormat.all.first }

      its(:target_id) { should eq doc.id }
      its(:field) { should eq field }
      its(:format) { should eq 'textile' }
    end

    context 'when not exists' do
      it 'inserted' do
        expect { PwfmtFormat.persist(doc, field, 'textile') }.to change { PwfmtFormat.count }.by(1)
      end
      describe 'values cofirmation' do
        before do
          PwfmtFormat.persist(doc, field, 'textile')
        end
        it_behaves_like 'format persistence'
      end
    end
    context 'when already exists' do
      before do
        PwfmtFormat.create(target_id: doc.id,
                           field: field,
                           format: 'markdown')
      end

      it 'not inserted' do
        expect { PwfmtFormat.persist(doc, field, 'textile') }.not_to change { PwfmtFormat.count }
      end
      describe 'values cofirmation' do
        before do
          PwfmtFormat.persist(doc, field, 'textile')
        end
        it_behaves_like 'format persistence'
      end
    end
  end

  describe '.persist_all_as' do
    fixtures :projects, :issues, :journals, :documents, :news, :comments, :wikis, :wiki_pages, :wiki_contents, :wiki_content_versions

    Redmine::WikiFormatting.format_names.each do |format|
      context "when given format is #{format}" do
        before { PwfmtFormat.persist_all_as(format) }

        it 'descriptions of all projects are persisted' do
          Project.all.each do |prj|
            pwfmt_format = PwfmtFormat.where(target_id: prj.id, field: 'project_description').first
            if prj.description.present?
              expect(pwfmt_format).not_to be_nil
              expect(pwfmt_format.format).to eq format
            else
              expect(pwfmt_format).to be_nil
            end
          end
        end
        it 'descriptions of all issues are persisted' do
          Issue.all.each do |issue|
            pwfmt_format = PwfmtFormat.where(target_id: issue.id, field: 'issue_description').first
            if issue.description.present?
              expect(pwfmt_format).not_to be_nil
              expect(pwfmt_format.format).to eq format
            else
              expect(pwfmt_format).to be_nil
            end
          end
        end
        it 'notes of all journals are persisted' do
          Journal.all.each do |journal|
            pwfmt_format = PwfmtFormat.where(target_id: journal.id, field: 'journal_notes').first
            if journal.notes.present?
              expect(pwfmt_format).not_to be_nil
              expect(pwfmt_format.format).to eq format
            else
              expect(pwfmt_format).to be_nil
            end
          end
        end
        it 'descriptions of all documents are persisted' do
          Document.all.each do |doc|
            pwfmt_format = PwfmtFormat.where(target_id: doc.id, field: 'document_description').first
            if doc.description.present?
              expect(pwfmt_format).not_to be_nil
              expect(pwfmt_format.format).to eq format
            else
              expect(pwfmt_format).to be_nil
            end
          end
        end
        it 'descriptions of all news are persisted' do
          News.all.each do |news|
            pwfmt_format = PwfmtFormat.where(target_id: news.id, field: 'news_description').first
            if news.description.present?
              expect(pwfmt_format).not_to be_nil
              expect(pwfmt_format.format).to eq format
            else
              expect(pwfmt_format).to be_nil
            end
          end
        end
        it 'descriptions of all messages are persisted' do
          Message.all.each do |msg|
            pwfmt_format = PwfmtFormat.where(target_id: msg.id, field: 'message_content').first
            if msg.content.present?
              expect(pwfmt_format).not_to be_nil
              expect(pwfmt_format.format).to eq format
            else
              expect(pwfmt_format).to be_nil
            end
          end
        end
        it 'descriptions of all comments are persisted' do
          Comment.all.each do |comment|
            pwfmt_format = PwfmtFormat.where(target_id: comment.id, field: 'comment_comments').first
            if comment.comments.present?
              expect(pwfmt_format).not_to be_nil
              expect(pwfmt_format.format).to eq format
            else
              expect(pwfmt_format).to be_nil
            end
          end
        end
        it 'descriptions of all wiki contents are persisted' do
          WikiContent.all.each do |wiki_content|
            wiki_content.versions.each do |version|
              pwfmt_format = PwfmtFormat.where(target_id: wiki_content.id, field: "wiki_content:v#{version.version}").first
              if wiki_content.text.present?
                expect(pwfmt_format).not_to be_nil
                expect(pwfmt_format.format).to eq format
              else
                expect(pwfmt_format).to be_nil
              end
            end
          end
        end
      end
    end
  end
end
