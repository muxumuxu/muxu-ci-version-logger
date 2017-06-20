module VersionLogger
  class Railtie < Rails::Railtie
    rake_tasks do
      load 'tasks/version_logger_tasks.rake'
    end

    generators do
      require 'generators/setup.rb'
    end
  end
end
