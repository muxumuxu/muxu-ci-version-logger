namespace :version_logger do
  root = Rails.root

  changelog_file = "#{root}/CHANGELOG.md"
  tmp_dir = "#{root}/tmp"

  def setup!
    @configuration = VersionLogger.configuration

    @app_name = Rails.application.class.name.split('::').first
    @app_version = "#{@app_name}::Application::VERSION".constantize
  end

  task version: :environment do
    setup!

    puts @app_version
  end

  task increment_patch: :environment do
    setup!

    (major,minor,patch) = /(\d+)\.(\d+)\.(\d+)/.match(@app_version)[1..3]

    version = "#{major}.#{minor}.#{patch.to_i + 1}"

    File.open("#{root}/config/initializers/version.rb", "w") do |file|
      file.write("module #{@app_name}\n  class Application\n    VERSION = '#{version}'\n  end\nend")
    end
  end

  task update_changelog: :environment do
    setup!

    changelog = File.read(changelog_file)

    parser = Vandamme::Parser.new(changelog: changelog, format: :md, version_header_exp: '^#{0,3} ?([\w\d\.-]+\.[\w\d\.-]+[a-zA-Z0-9]|Unreleased)(?: \W (\w+ \d{1,2}(?:st|nd|rd|th)?,\s\d{4}|\d{4}-\d{2}-\d{2}|\w+))?\n?[=-]*')

    hash = parser.parse

    if changes = hash['Unreleased']
      changelog = changelog.gsub('Unreleased', "v#{@app_version} / #{Date.today.to_s}")

      File.open(changelog_file, "w") { |file| file.write changelog }

      # Only writing json if slack infos are available
      if @configuration.slack_channel && @configuration.slack_user
        File.open("#{tmp_dir}/changes.json", 'w') do |file|
          file.write '{"channel":"' + @configuration.slack_channel + '","username":"' + @configuration.slack_user + '",'
          file.write '"text":"<!here> *' + @configuration.project_name + ' has been deployed to v'
          file.write @app_version
          file.write '*\n'
          file.write changes.gsub("\n", '\n').gsub('"', '\"')
          file.write '"}'
        end
      end

      File.open("#{tmp_dir}/changes.txt", 'w') { |file| file.write changes.gsub('"', '\"') }
    end
  end
end
