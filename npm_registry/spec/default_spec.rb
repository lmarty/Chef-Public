require 'spec_helper'

describe "#{File.basename(Dir.getwd)}::default" do
  let(:chef_run) {
    ChefSpec::ChefRunner.new(
      :evaluate_guards => true,
      platform: 'ubuntu',
      version:'12.04'
    )
  }

  before(:each){
    File.stub(:exists?).and_call_original
  }

  it 'should install and configure default steps when the couch database file is missing' do
    chef_run.node.set['couch_db']['config']['couchdb']['database_dir'] = '/usr/local/var/lib/couchdb'

    File.should_receive(:exists?).with('/usr/local/var/lib/couchdb/registry.couch').and_return(false)

    chef_run.converge("#{described_cookbook}::default")

    expect(chef_run).to install_package 'curl'
    expect(chef_run).to execute_command 'killall beam'
    expect(chef_run).to restart_service 'couchdb'
  end

  it 'should install and configure default steps when the couch database file is not missing' do
    chef_run.node.set['couch_db']['config']['couchdb']['database_dir'] = '/usr/local/var/lib/couchdb'

    File.should_receive(:exists?).with('/usr/local/var/lib/couchdb/registry.couch').and_return(true)

    chef_run.converge("#{described_cookbook}::default")

    expect(chef_run).to install_package 'curl'
    expect(chef_run).to execute_command 'killall beam'
    expect(chef_run).to restart_service 'couchdb'
  end

  it 'should install and configure an NPM registry when the couch database file is missing' do
    chef_run.node.set['couch_db']['config']['couchdb']['database_dir'] = '/usr/local/var/lib/couchdb'

    File.should_receive(:exists?).with('/usr/local/var/lib/couchdb/registry.couch').and_return(false)

    chef_run.converge("#{described_cookbook}::default")

    expect(chef_run).to log "Created registry database"
    expect(chef_run).to log "Cloned #{chef_run.node.default['npm_registry']['git']['url']}@#{chef_run.node.default['npm_registry']['git']['reference']}"
    expect(chef_run).to execute_command 'npm install couchapp -g'
    expect(chef_run).to execute_command 'npm install couchapp'
    expect(chef_run).to execute_command 'npm install semver'
    expect(chef_run).to execute_command './push.sh'
    expect(chef_run).to execute_command './load-views.sh'
    expect(chef_run).to execute_bash_script "COPY _design/app"
    expect(chef_run).to execute_command "couchapp push www/app.js #{Pathname.new(chef_run.node.default['npm_registry']['registry']['url']).cleanpath().to_s().gsub(':/', '://')}/registry"
  end

  it 'should not install and configure an NPM registry when the couch database file is not missing' do
    chef_run.node.set['couch_db']['config']['couchdb']['database_dir'] = '/usr/local/var/lib/couchdb'

    File.should_receive(:exists?).with('/usr/local/var/lib/couchdb/registry.couch').and_return(true)

    chef_run.converge("#{described_cookbook}::default")

    expect(chef_run).not_to log "Created registry database"
    expect(chef_run).not_to log "Cloned #{chef_run.node.default['npm_registry']['git']['url']}@#{chef_run.node.default['npm_registry']['git']['reference']}"
    expect(chef_run).not_to execute_command 'npm install couchapp -g'
    expect(chef_run).not_to execute_command 'npm install couchapp'
    expect(chef_run).not_to execute_command 'npm install semver'
    expect(chef_run).not_to execute_command './push.sh'
    expect(chef_run).not_to execute_command './load-views.sh'
    expect(chef_run).not_to execute_bash_script "COPY _design/app"
    expect(chef_run).not_to execute_command "couchapp push www/app.js #{Pathname.new(chef_run.node.default['npm_registry']['registry']['url']).cleanpath().to_s().gsub(':/', '://')}/registry"
  end

  it 'should not use replication' do
    chef_run.node.set['npm_registry']['replication']['flavor'] = 'none'

    chef_run.converge('cron::default', "#{described_cookbook}::default")

    expect(chef_run).not_to log 'Configured scheduled replication'
    expect(chef_run).to log 'Skipping replication'
  end

  it 'should use scheduled replication' do
    chef_run.node.set['npm_registry']['replication']['flavor'] = 'scheduled'

    chef_run.converge('cron::default', "#{described_cookbook}::default")

    expect(chef_run).to log 'Configured scheduled replication'
  end

  it 'should use continuous replication' do
    chef_run.node.set['npm_registry']['replication']['flavor'] = 'continuous'

    chef_run.converge("#{described_cookbook}::default")

    expect(chef_run).to log 'Configured continuous replication'
  end
end