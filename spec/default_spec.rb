# encoding: utf-8
require 'spec_helper'

describe 'ntp::default' do
  let(:chef_run) do
    ChefSpec::Runner.new do |node|
      # override cookbook attributes
      node.set['file']['header'] = 'node.file.header'
      node.set['ntp']['server'] = 'time.nist.gov'
    end.converge(described_recipe)
  end # let

  describe 'ntp' do
    it 'installs described package' do
      expect(chef_run).to install_package(subject)
    end # it
  end # describe

  it 'stops ntpd' do
    expect(chef_run).to stop_service('ntpd')
  end # it

  it 'disables ntpd' do
    expect(chef_run).to disable_service('ntpd')
  end # it

  describe '/etc/cron.hourly/ntpdate' do
    it 'creates template with expected owner, group' do
      expect(chef_run).to create_template(subject)
        .with(:owner => 'root', :group => 'root')
    end # it

    it 'renders file with expected header' do
      expect(chef_run).to render_file(subject)
        .with_content('node.file.header')
    end # it
  end # describe

  # it 'executes /usr/sbin/ntpdate time.nist.gov' do
  #   expect(chef_run).to execute_command('/usr/sbin/ntpdate time.nist.gov')
  # end # it

end # describe
