task :default => :test
task :test do sh 'rspec spec' end
task :dev do
  sh 'urxvt -e $PWD/guard &'
  sh './edit'
end
