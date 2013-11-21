$:.push File.dirname(__FILE__); require 'spec_helper'
require 'chefspec'

describe 'rayo::node', :focus => true do

  before(:each) do
    module Rayo; end
    Rayo.stub(:sha256){ "abc123" }
  end

  let(:chef_run) do
    ChefSpec::ChefRunner.new do |node|

      node[:languages]={"ruby"=>{"platform"=>"x86_64-linux", "version"=>"1.9.2", "release_date"=>"2011-07-09", "target"=>"x86_64-unknown-linux-gnu", "target_cpu"=>"x86_64", "target_vendor"=>"unknown", "target_os"=>"linux", "host"=>"x86_64-unknown-linux-gnu", "host_cpu"=>"x86_64", "host_os"=>"linux-gnu", "host_vendor"=>"unknown", "bin_dir"=>"/usr/local/bin", "ruby_bin"=>"/usr/local/bin/ruby", "gems_dir"=>"/usr/local/lib/ruby/gems/1.9.1", "gem_bin"=>"/usr/local/bin/gem"  }}
      node[:rayo]={:artifacts=>{:checksum => "abc123" }}

      rayo_tmp='/opt/chef/rayo'
    end.converge 'rayo::node'

    it 'should calculate the artifact checksum' do
      Rayo.should_receive(:sha256).with("/opt/chef/rayo/rayo.war")

      runner = ChefSpec::ChefRunner.new
      runner.converge 'rayo::default'
    end
  end
end
