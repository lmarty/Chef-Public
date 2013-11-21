require 'chefspec'

describe 'x2go::yum_repo' do
  

=begin

  Original code to test repo
  
  before do
    @chef_run = ::ChefSpec::ChefRunner.new.converge 'x2go::default'
  end
  
  it 'should create a repo if it does not exists' do
    
    resource = @chef_run.find_resource("yum_repository", "x2go").to_hash
    
    expect(resource).to include(
      :repo_name => 'x2go',
      :description => 'x2go (replaces NX)',
      :url => "http://download.opensuse.org/repositories/X11:/RemoteDesktop:/x2go/RHEL_6",
      :key => "http://download.opensuse.org/repositories/X11:/RemoteDesktop:/x2go/RHEL_6/repodata/repomd.xml.key",
     :action => [:add]
    )
  end
=end

  let(:chef_run) {
    ChefSpec::ChefRunner.new(:platform => 'centos', :version => '6.0').converge 'x2go::yum_repo'
  }

  it 'should import the key' do  
    expect(chef_run.find_resource('yum_key','x2go.key').to_hash).to include(
      :url => "http://download.opensuse.org/repositories/X11:/RemoteDesktop:/x2go/RHEL_6/repodata/repomd.xml.key",
      :action => [:add]
    )
  end
   
  it 'should create a repo if it does not exists' do  
    expect(chef_run.find_resource('yum_repository','x2go').to_hash).to include(
      :repo_name => 'x2go',
      :description => 'x2go (replaces NX)',
      :url => "http://download.opensuse.org/repositories/X11:/RemoteDesktop:/x2go/RHEL_6",
      :action => [:add]
    )
  end

end