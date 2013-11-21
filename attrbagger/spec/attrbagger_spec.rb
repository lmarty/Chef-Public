require 'attrbagger'
require 'chef/node'
require 'chef/mixin/deep_merge'

describe Attrbagger do
  let :loader_from_base_and_env do
    described_class.new(
      :run_context => run_context,
      :data_bag => data_bag_name,
      :base_config => base_config_name,
      :env_config => env_config_name
    )
  end

  let :loader_from_bag_cascade do
    described_class.new(
      :run_context => run_context,
      :bag_cascade => bag_cascade
    )
  end

  let(:data_bag_name) { 'soup' }
  let(:base_config_name) { 'flurb' }
  let(:env_config_name) { 'flurb_demo' }
  let(:bag_cascade) do
    ['data_bag_item[soup::flurb]', 'data_bag_item[soup::flurb_demo]']
  end

  let(:default_qwwx) { rand(300..399) }

  let :node do
    n = Chef::Node.new
    n.instance_variable_set(:@name, 'nodersons')
    n.default['deployment_env'] = 'uat'
    n.default['attrbagger'] = {
      'configs' => {
        'flurb::foop' => {
          'precedence_level' => 'override',
          'bag_cascade' => [
            'data_bag_item[derps::ham]',
            'data_bag_item[noodles::foop]',
            "data_bag_item[app::config_<%= node['deployment_env'] %>::foop]"
          ],
        },
        'bork' => {'bag_cascade' => ['data_bag_item[ack']}
      },
      'precedence_level' => 'override'
    }
    n.default['flurb'] = {
      'foop' => {
        'bzzrt' => rand(0..99),
        'qwwx' => default_qwwx
      }
    }
    n
  end

  let :run_context do
    double('run_context').tap do |ctx|
      ctx.stub(:log)
      ctx.stub(:node => node)
    end
  end

  let :base_data_bag_item_content do
    {
      'soup' => {
        'flurb' => {
          'watched_logs' => {
            'nginx' => 'glob:/var/log/nginx/*.log'
          },
          'excluded_logs' => {
            'debug' => 'glob:/var/log/**/*-debug.log'
          }
        }
      }
    }.tap do |h|
      h.stub(:raw_data) { h }
    end
  end

  let :env_data_bag_item_content do
    {
      'soup' => {
        'flurb' => {
          'server_search' => 'role:jammies'
        }
      }
    }.tap do |h|
      h.stub(:raw_data) { h }
    end
  end

  %w(base_and_env bag_cascade).each do |loader_type|
    subject(:loader) { send(:"loader_from_#{loader_type}") }

    before do
      loader.stub(:data_bag_item) do |_, config|
        case config
        when base_config_name
          base_data_bag_item_content
        when env_config_name
          env_data_bag_item_content
        else
          nil
        end
      end
    end

    context "when loaded from #{loader_type.gsub(/_/, ' ')}" do
      it 'merges base config with env config' do
        loaded = loader.load_config
        loaded['soup']['flurb']['server_search'].should == 'role:jammies'
        loaded['soup']['flurb']['watched_logs'].should_not be_empty
      end

      it 'rejects id, chef_type, and data_bag keys' do
        loaded = loader.load_config
        %w(id chef_type data_bag).each do |key|
          loaded.should_not have_key(key)
        end
      end

      context 'when no configs are found' do
        let :run_context do
          double('run_context').tap do |ctx|
            ctx.stub(:log)
            ctx.stub(:node => node)
          end
        end

        before do
          loader.stub(:data_bag_item).and_raise(Class.new(StandardError).new)
        end

        it 'does not explode' do
          expect { loader.load_config }.to_not raise_error
        end
      end
    end
  end

  context 'when expanding the bag cascade' do
    subject(:loader) { loader_from_bag_cascade }

    before do
      loader.instance_variable_set(:@bag_cascade, [
        'data_bag_item[fizz::buzz]',
        'data_bag_item[foo::<%= node.name %>]'
      ])
    end

    it 'renders embedded ERB' do
      loader.expanded_bag_cascade.should == [
        'data_bag_item[fizz::buzz]',
        'data_bag_item[foo::nodersons]'
      ]
    end

    it 'exposes run_context for rendering' do
      loader.run_context.should == run_context
    end

    it 'exposes node for rendering' do
      loader.node.should == node
    end
  end

  context 'when fetching keys for keyspecs' do
    subject { described_class }

    it 'fetches the right nested value' do
      ham = rand(300..399)
      subject.fetch_key_for_keyspec('fizz::buzz::ham', {
        'fizz' => {
          'buzz' => {
            'ham' => ham
          }
        }
      }).should == ham
    end
  end

  context 'when assigning values to keyspecs' do
    subject { described_class }

    it 'assigns to the right level' do
      new_qwwx = rand(10..19)
      fake_node = Chef::Node.new
      fake_node.instance_variable_set(:@name, 'fakey')
      fake_node.default['bar'] = {
        'baz' => {
          'qwwx' => 2
        }
      }
      subject.assign_to_keyspec(fake_node.override, 'bar::baz::qwwx', new_qwwx)
      fake_node['bar']['baz']['qwwx'].should == new_qwwx
    end
  end

  context 'when auto loading' do
    let :run_context do
      double('run_context').tap do |ctx|
        ctx.stub(:log)
        ctx.stub(:node => node)
      end
    end

    let(:bag_bzzrt) { rand(100..199) }
    let(:bag_boop) { rand(200..299) }

    let :data_bags do
      {
        'derps' => {
          'ham' => {
            'bones' => 9000,
            'beans' => 2
          }
        },
        'noodles' => {
          'foop' => {
            'bzzrt' => bag_bzzrt
          }
        },
        'app' => {
          'config_' => {
            'foop' => {
              'bzzrt' => 4
            }
          },
          'config_uat' => {
            'foop' => {
              'boop' => bag_boop
            }
          }
        }
      }
    end

    before do
      Attrbagger.any_instance.stub(:data_bag_item) do |bag, item|
        (data_bags[bag] || {})[item]
      end
    end

    it 'merges attributes into the node based on bag configs' do
      Attrbagger.autoload!(run_context)
      node['flurb']['foop']['bzzrt'].should == bag_bzzrt
      node['flurb']['foop']['qwwx'].should == default_qwwx
    end

    it 'ignores malformed data bag specifications' do
      Attrbagger.autoload!(run_context)
      node['bork'].should be_nil
    end

    it 'renders bag cascade strings with ERB' do
      Attrbagger.autoload!(run_context)
      node['flurb']['foop']['boop'].should == bag_boop
    end
  end
end
