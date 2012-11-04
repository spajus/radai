# coding: utf-8
require 'spec_helper'

describe Specialist do

  it 'should have a correct slug for lithuanian names' do
    specialist = Specialist.new

    specialist.title = "Lolitukas"
    specialist.title_slug.should eq 'lolitukas'

    specialist.title = "Jonas Jonaitis"
    specialist.title_slug.should eq 'jonas-jonaitis'

    specialist.title = "Žėrūtis Čębųrėšką"
    specialist.title_slug.should eq 'zerutis-cebureska'

    specialist.title = "ĄČĘĖĮŠŲŪŽ  ąčęėįšųūž"
    specialist.title_slug.should eq 'aceeisuuz-aceeisuuz'
  end
end
