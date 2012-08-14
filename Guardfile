# https://github.com/guard/guard#readme
guard :rspec do
  watch %r{^lib/(.+)\.rb$} do |m| "spec/#{m[1]}_spec.rb" end
  watch %r{^spec/.*}
end
# vim:ft=ruby
