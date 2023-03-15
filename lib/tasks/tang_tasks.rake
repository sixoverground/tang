# desc "Explaining what the task does"
# task :tang do
#   # Task goes here
# end

task :rails_best_practices do
  path = File.expand_path('../../../', __FILE__)
  sh "rails_best_practices #{path}"
end

task :brakeman do
  sh 'brakeman -q -z'
end

task :check do
  Rake::Task['spec'].invoke
  Rake::Task['cucumber'].invoke
  Rake::Task['brakeman'].invoke
  Rake::Task['rails_best_practices'].invoke
end

namespace :tang do
  task import_stripe: :environment do
    Tang::ImportStripeJob.perform_now
  end
end
