module Pwfmt
  module Testing
    # Helper module for creating test data to database.
    module DataHelper
      def load_default_data(lang = 'en')
        Setting.default_language = lang
        Setting.force_default_language_for_anonymous = '1'
        Redmine::DefaultData::Loader.load(lang)
      end

      def create_test_user
        password = 'foobarbaztest'
        user = User.where(login: 'test').first
        unless user
          user = User.new(firstname: 'Redmine', lastname: 'Test', mail: 'test@example.net')
          user.login = 'test'
        end
        user.password = password
        user.language = 'en'
        user.save!
      end

      def select_text_for(format)
        Redmine::WikiFormatting.formats_for_select.find { |f| f.last == format }.first
      end

      def create_project
        project = Project.create!(name: project_id, identifier: project_id)
        principal = Principal.find(User.where(login: 'test').pluck(:id).first)
        membership = { project_id: project.id, role_ids: Role.where(name: 'Manager').pluck(:id) }
        Member.create_principal_memberships(principal, membership)
      end

      def create_forum
        Board.create!(project: Project.find(project_id),
                      name: 'bbs',
                      description: 'This is bbs.',
                      position: 1,
                      topics_count: 0,
                      messages_count: 0)
      end
    end
  end
end
