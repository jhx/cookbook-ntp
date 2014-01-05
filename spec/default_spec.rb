# coding: utf-8
require 'spec_helper'

describe 'ntp::default' do
  let(:chef_run) do
    ChefSpec::Runner.new do |node|
      # override cookbook attributes
      node.set['file'] = {
        'header' => 'node.file.header'
      }
      node.set['ntp'] = {
        'server' => 'time.nist.gov'
      }
    end.converge(described_recipe)
  end # let

  it 'should install ntp' do
    expect(chef_run).to install_package('ntp')
  end # it

  it 'should stop ntpd' do
    expect(chef_run).to stop_service('ntpd')
  end # it

  it 'should disable ntpd' do
    expect(chef_run).to disable_service('ntpd')
  end # it

  it 'should create /etc/cron.hourly/ntpdate owned by root:root' do
    file = '/etc/cron.hourly/ntpdate'
    expect(chef_run).to render_file(file).with_content('node.file.header')
    expect(chef_run.template(file).owner).to eq('root')
    expect(chef_run.template(file).group).to eq('root')
  end # it

  # it 'should execute /usr/sbin/ntpdate time.nist.gov' do
  #   expect(chef_run).to execute_command('/usr/sbin/ntpdate time.nist.gov')
  # end # it

end # describe
