# coding: utf-8
require 'spec_helper'

describe 'ntp::default' do
  describe package('ntp') do
    it 'is installed' do
      expect(subject).to be_installed
    end # it
  end # describe

  describe service('ntp') do
    it 'is not running' do
      expect(subject).to_not be_running
    end # it

    it 'is not enabled' do
      expect(subject).to_not be_enabled
    end # it
  end # describe

  describe file('/etc/cron.hourly/ntpdate') do
    it 'is file' do
      expect(subject).to be_file
    end # it

    it 'is owned by root' do
      expect(subject).to be_owned_by('root')
    end # it

    it 'is in group root' do
      expect(subject).to be_grouped_into('root')
    end # it

    it 'is mode 755' do
      expect(subject).to be_mode(755)
    end # it

    it 'includes expected content' do
      expect(subject.content).to include(
        'ntpdate fake.time.server >> /dev/null 2>&1'
      )
    end # it
  end # describe

end # describe
