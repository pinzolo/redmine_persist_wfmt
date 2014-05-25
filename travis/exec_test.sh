#! /bin/sh

export REDMINE_LANG=en
export RAILS_ENV=test

# Initialize redmine
bundle exec rake generate_secret_token
bundle exec rake db:migrate
#bundle exec rake redmine:load_default_data

# Copy assets & execute plugin's migration
bundle exec rake redmine:plugins NAME=redmine_persist_wfmt

if [ $TARGET = "redmine" ]; then
  export SCMS=bazaar,cvs,subversion,git,mercurial,filesystem

  # Execute redmine tests
  bundle exec rake ci
else
  # Initialize RSpec
  bundle exec rails g rspec:install

  # Execute plugin test by RSpec
  bundle exec rspec plugins/redmine_persist_wfmt/spec -c
fi

