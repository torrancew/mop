task :default => :test
task :test do sh 'rspec spec' end
task :dev do
  sh 'urxvt -e bundle exec guard &'
  sh './edit'
end
