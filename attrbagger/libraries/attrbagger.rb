# vim:fileencoding=utf-8

require 'chef'
require 'chef/dsl/data_query'
require 'chef/log'
require 'chef/mixin/deep_merge'

class Attrbagger
  include Chef::DSL::DataQuery

  class << self
    def autoload!(run_context)
      log.info("Attrbagger auto-loading for #{run_context.node}")
      run_context.node['attrbagger']['configs'].each do |keyspec, config|
        loader = Attrbagger.new(
          run_context: run_context, bag_cascade: [*config['bag_cascade']]
        )
        bag_config = loader.load_config

        if bag_config && !bag_config.empty?
          precedence_level = run_context.node.send(
            config['precedence_level'] || node['attrbagger']['precedence_level']
          )

          assignment_level = fetch_key_for_keyspec(keyspec, precedence_level)
          new_value = bag_config
          if assignment_level
            new_value = Chef::Mixin::DeepMerge.merge(
              assignment_level, bag_config
            )
          end

          assign_to_keyspec(precedence_level, keyspec, new_value)
        end

        log.info("Attrbagger done auto-loading " <<
                 "#{keyspec.inspect} => #{loader.expanded_bag_cascade.inspect}")
      end
    end

    def fetch_key_for_keyspec(keyspec, bag_item)
      if !keyspec
        return bag_item
      end
      lookup = keyspec.split('::')
      nlevel = 0
      item_level = bag_item
      while key = lookup[nlevel]
        item_level = item_level[key] || {}
        nlevel += 1
      end
      item_level
    end

    def assign_to_keyspec(hashlike, keyspec, value)
      lookup = keyspec.split('::')
      key = lookup.pop
      hash_level = hashlike
      if !lookup.empty?
        hash_level = fetch_key_for_keyspec(lookup.join('::'), hash_level)
      end
      log.debug("Assigning to #{keyspec.inspect} new value #{value.inspect}")
      hash_level[key] = value
    end

    def log
      Chef::Log
    end
  end

  attr_reader :bag_cascade

  def initialize(options = {})
    @run_context = options.fetch(:run_context)
    if options[:bag_cascade]
      @bag_cascade = options[:bag_cascade]
    else
      @bag_cascade = [
        "data_bag_item[#{options.fetch(:data_bag)}::#{options.fetch(:base_config)}]",
        "data_bag_item[#{options.fetch(:data_bag)}::#{options.fetch(:env_config)}}]"
      ]
    end
  end

  def load_config
    top = {}
    expanded_bag_cascade.each do |s|
      bag_item = load_data_bag_item_from_string(s)
      if !bag_item || !bag_item.empty?
        top.merge!(Chef::Mixin::DeepMerge.merge(top, bag_item))
      end
    end
    top.empty? ? nil : top
  end

  def expanded_bag_cascade
    @bag_cascade.map { |s| render(s) }
  end

  def node
    @run_context.node
  end

  def run_context
    @run_context
  end

  def log
    self.class.log
  end

  private

  def render(string)
    ERB.new(string, 3).result(binding)
  end

  def load_data_bag_item_from_string(bag_string)
    if bag_string =~ /^(.+)\[(.+)\]$/
      if $1 == 'data_bag_item'
        bag, item, keyspec = $2.split('::', 3)
        self.class.fetch_key_for_keyspec(
          keyspec, load_data_bag_item(bag, item || bag)
        )
      else
        log.warn("Only 'data_bag_item' resources are supported by " <<
                 "Attrbagger, not #{$1.inspect}.")
        return {}
      end
    else
      log.warn("Invalid resource specification string #{bag_string.inspect}.")
      nil
    end
  end

  def load_data_bag_item(bag_name, item_name)
    (data_bag_item(bag_name, item_name) || {}).reject do |key,_|
      %(id chef_type data_bag).include?(key)
    end
  rescue StandardError => e
    log.warn("#{e.class.name} #{e.message}")
    {}
  end
end
