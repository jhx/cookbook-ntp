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
    chef_run.should install_package 'ntp'
  end # it 'should install ntp'
  
  it 'should stop ntpd' do
    chef_run.should stop_service 'ntpd'
  end # it 'should stop ntpd'
  
  it 'should disable ntpd' do
    chef_run.should disable_service 'ntpd'
  end # it 'should disable ntpd'
  
  it 'should create /etc/cron.hourly/ntpdate owned by root:root' do
    file = '/etc/cron.hourly/ntpdate'
    chef_run.should create_file_with_content file, 'node.file.header'
    expect(chef_run.template(file).owner).to eq('root')
    expect(chef_run.template(file).group).to eq('root')
  end # it 'should create /etc/cron.hourly/ntpdate owned by root:root'

  # it 'should execute /usr/sbin/ntpdate time.nist.gov' do
  #   chef_run.should execute_command '/usr/sbin/ntpdate time.nist.gov'
  # end # it 'should execute /usr/sbin/ntpdate time.nist.gov'

end # describe 'ntp::default'
