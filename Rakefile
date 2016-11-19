begin
  require 'bundler/setup'
rescue LoadError
  puts 'You must `gem install bundler` and `bundle install` to run rake tasks'
end

require 'rdoc/task'

RDoc::Task.new(:rdoc) do |rdoc|
  rdoc.rdoc_dir = 'rdoc'
  rdoc.title    = 'Tang'
  rdoc.options << '--line-numbers'
  rdoc.rdoc_files.include('README.rdoc')
  rdoc.rdoc_files.include('lib/**/*.rb')
end

APP_RAKEFILE = File.expand_path("../spec/tang_app/Rakefile", __FILE__)
load 'rails/tasks/engine.rake'

load 'rails/tasks/statistics.rake'

Bundler::GemHelper.install_tasks

load './lib/tasks/tang_tasks.rake'

begin
  require 'rspec/core/rake_task'
  RSpec::Core::RakeTask.new(spec: 'app:db:test:prepare')
  task :cucumber => 'app:cucumber'
  task default: [:spec, :cucumber]
rescue LoadError
  puts 'rspec/core/rake_task not required'
end

namespace :assets do
  desc 'Precompile assets within dummy app'
  task :precompile do
    Dir.chdir('spec/tang_app') do
      system('bundle exec rake assets:precompile')
    end
  end
  desc 'Clean assets within dummy app'
  task :clean do
    Dir.chdir('spec/tang_app') do
      system('bundle exec rake assets:clean')
    end
  end
end

namespace :rails do
  desc 'Run rails console within dummy app'
  task :console do
    Dir.chdir('spec/tang_app') do
      system('rails c')
    end
  end 
end
