require 'chefspec'
require 'fauxhai'

describe 'ntp::default' do
  before do
    Fauxhai.mock do |node|
      node['file'] = {
        'header' => 'node.file.header'
      }
      node['ntp'] = {
        'server' => 'time.nist.gov'
      }
    end # Fauxhai.mock
  end # before
  
  let (:chef_run) { ChefSpec::ChefRunner.new.converge 'ntp::default' }
  
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
    chef_run.template(file).should be_owned_by 'root', 'root'
  end # it 'should create /etc/cron.hourly/ntpdate owned by root:root'
  
  it 'should execute /usr/sbin/ntpdate time.nist.gov' do
    chef_run.should execute_command '/usr/sbin/ntpdate time.nist.gov'
  end # it 'should execute /usr/sbin/ntpdate time.nist.gov'
  
end # describe 'ntp::default'
