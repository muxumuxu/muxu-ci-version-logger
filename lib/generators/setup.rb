class VersionLogger::SetupGenerator < Rails::Generators::Base
  desc 'Gets app name'
  def app_name
    @app_name = if defined?(Rails) && Rails.application
                  Rails.application.class.name.split('::').first
                else
                  "Application"
                end
  end

  desc 'Adds vandamme gem'
  def add_vandamme
    gem 'vandamme', group: [:development, :test]
  end

  desc 'Creates a version file'
  def create_version_file
    version = ask 'What is the current version of the app? [0.0.0]'
    version = '0.0.0' if version.blank?

    initializer 'version.rb', "module #{@app_name}\n  class Application\n    VERSION = '#{version}'\n  end\nend"
  end

  desc 'Creates an initializer file'
  def create_initializer_file
    project_name = ask 'What is the project name?'
    project_name = @app_name.underscore.dasherize if project_name.blank?

    slack_user = ask 'What is the Slack username to post with? [Bamboo]'
    slack_user = 'Bamboo' if slack_user.blank?

    slack_channel = ask "What is the project slack channel? [#prj-#{project_name.downcase}]"
    slack_channel = "#prj-#{project_name.downcase}" if slack_channel.blank?

    initializer 'version_logger.rb', "if Rails.env.development? || Rails.env.test?\n  VersionLogger.configure do |config|\n    config.project_name = '#{project_name}'\n    config.slack_user = '#{slack_user}'\n    config.slack_channel = '#{slack_channel}'\n  end\nend"
  end

  desc 'Adds a CHANGELOG.md'
  def create_changelog_file
    create_file 'CHANGELOG.md', "# Changelog\n\n## Upcoming\n\n## Versions\n### Unreleased"
  end
end
