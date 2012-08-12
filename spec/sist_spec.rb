require 'spec_helper'

describe Sist do
  context 'password filtration' do
    input = <<-EOT.split /\n/
password: secr3t
password: 'secr3t'
password:secr3t
passwd:secr3t
passwd: secr3t
password=secr3t
passwd=secr3t
password="secr3t"
buzbuz password: secr3t bizbiz
buzbuz password: secr3t bizbiz another password: secr3t bazbaz
password=secr3t
passwd=secr3t
USER: user55 PASS: secr3t
U/N: user55 P/W: secr3t
U: user55 P: secr3t
U=user55 P=secr3t
u=user55 p=secr3t
u: user55 p: secr3t
L=user55 P=secr3t
    EOT
    input.each do |e|
      it "should catch #{e}" do
        Sist.sanitize(e).should_not match(/secr3t/)
      end
    end
  end
end
