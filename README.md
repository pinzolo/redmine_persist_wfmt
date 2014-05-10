# redmine_persist_wfmt

redmine_persist_wfmt is a plugin for Redmine that persists wiki format.

## Installation

Execute follow commands at your Redmine directory.

### 1. Clone to your Redmine's plugins directory:

```shell
$ git clone https://gihub.com/pinzolo/redmine_persist_wfmt.git plugins/redmine_persist_wfmt
```

### 2. Install dependency gems:

```shell
$ bundle install
```

### 3. Execute migration and deploy assets:

```shell
$ bundle exec rake redmine:plugins NAME=redmine_persist_wfmt
```

### 4. Execute persist_all task:

```shell
# FORMAT is required and must be 'textile' or 'markdown'
$ bundle exec rake persist_all FORMAT=textile
```

### 5. Restart your redmine

```shell
# In case of using passenger
$ touch tmp/restart.txt
```

