require 'spec_helper'

describe Sist do
  context 'password filtration' do
    File.readlines('spec/passwords.in').each do |e|
      it "should catch #{e}" do
        Sist.sanitize(e).should_not match(/secr3t/)
        e.should match(/secr3t/)
      end
    end
  end
end
