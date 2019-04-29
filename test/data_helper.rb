module Pwfmt::Testing::DataHelper
  def load_default_data(lang = 'en')
    Redmine::DefaultData::Loader.load(lang)
  end

  def create_test_user
    password = 'foobarbaztest'
    user = User.where(login: 'test').first
    if user
      user.password = password
    else
      user = User.new(firstname: 'Redmine',
                      lastname: 'Test',
                      mail: 'test@example.net')
      user.login = 'test'
      user.password = password
    end
    user.language = 'en'
    user.save!
  end

  def create_project
    project = Project.create!(name: 'test', identifier: 'test')
    principal = Principal.find(User.where(login: 'test').pluck(:id).first)
    membership = { project_id: project.id, role_ids: Role.where(name: 'Manager').pluck(:id) }
    Member.create_principal_memberships(principal, membership)
  end

  def select_text_for(format)
    Redmine::WikiFormatting.formats_for_select.find { |f| f.last == format }.first
  end
end
