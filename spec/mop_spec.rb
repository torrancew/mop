# encoding: utf-8
require 'spec_helper'
require 'stringio'
require 'erb'

describe Mop do
  doc = StringIO.new
  cases = YAML.load_file('spec/cases.yml')
  $passwd_contents = cases.delete 'fake passwd file'
  def Mop.read_etc_passwd; $passwd_contents end
  $hostname = cases.delete 'fake hostname'
  def Mop.find_hostname; $hostname end
  cases.each do |name, intentions|
    context name do
      doc.puts '- ' + name
      intentions.each do |intention|
        if intention.has_key? 'passthru'
          intention['passthru'].each do |already_clean|
            it "should leave '#{already_clean}' alone" do
              Mop.wipe(already_clean).should eq(already_clean)
            end
            doc.puts "  - `#{already_clean.inspect}` _(unchanged)_"
          end
        elsif intention.has_key? 'filter' and intention.has_key? 'from'
          illicit = intention['filter']
          illicit = [illicit] unless illicit.is_a? Array
          intention['from'].each do |dirty|
            it "should not modify the original" do
              orig = dirty.dup
              Mop.wipe dirty
              dirty.should eq(orig)
            end
            it "should catch #{illicit} from #{dirty}" do
              clean = Mop.wipe dirty
              illicit.each do |e|
                clean.should_not include(e)
              end
            end
            doc.puts "  - `#{dirty.inspect}` ⇒ " +
              "`#{Mop.wipe(dirty).inspect}`"
          end
        else
          fail "Unknown test case: #{intention.to_yaml}"
        end
      end
    end
  end
  actual_results = doc.string
  template = ERB.new File.read('README.md.erb')
  File.open 'README.md', 'w' do |f| f.write template.result(binding) end
end
