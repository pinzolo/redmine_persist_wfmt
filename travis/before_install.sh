#! /bin/sh

if [ $TARGET = "redmine" ]; then
  # Setup scms
  sudo apt-get update -qq
  sudo apt-get --no-install-recommends install bzr cvs git mercurial subversion
fi

PLUGIN_NAME="redmine_persist_wfmt"

# Get & deploy Redmine
wget http://www.redmine.org/releases/redmine-${REDMINE_VERSION}.tar.gz
tar xf redmine-${REDMINE_VERSION}.tar.gz

# Copy plugin files to plugin directory
mkdir redmine-${REDMINE_VERSION}/plugins/${PLUGIN_NAME}
mv app      redmine-${REDMINE_VERSION}/plugins/${PLUGIN_NAME}/app
mv assets   redmine-${REDMINE_VERSION}/plugins/${PLUGIN_NAME}/assets
mv config   redmine-${REDMINE_VERSION}/plugins/${PLUGIN_NAME}/config
mv db       redmine-${REDMINE_VERSION}/plugins/${PLUGIN_NAME}/db
mv lib      redmine-${REDMINE_VERSION}/plugins/${PLUGIN_NAME}/lib
mv spec     redmine-${REDMINE_VERSION}/plugins/${PLUGIN_NAME}/spec
mv Gemfile  redmine-${REDMINE_VERSION}/plugins/${PLUGIN_NAME}/Gemfile
mv init.rb  redmine-${REDMINE_VERSION}/plugins/${PLUGIN_NAME}/init.rb

# Copy Gemfile.local
cat Gemfile.local >> redmine-${REDMINE_VERSION}/Gemfile.local

# Create necessary files
cat > redmine-${REDMINE_VERSION}/config/database.yml <<_EOS_
test:
  adapter: sqlite3
  database: db/redmine_test.db
_EOS_
cp redmine-${REDMINE_VERSION}/plugins/${PLUGIN_NAME}/spec/fixtures/* redmine-${REDMINE_VERSION}/test/fixtures/

# All move to work directory
mv redmine-${REDMINE_VERSION}/* .

