# encoding: utf-8
actions :create, :destroy, :killall, :run

default_action :create

attribute :container, name_attribute: true

attribute :command, kind_of: [String]
attribute :config, kind_of: [String]
attribute :id, kind_of: [String]
attribute :nowait, kind_of: [TrueClass, FalseClass]
attribute :processes, kind_of: [Array]
attribute :spec, kind_of: [String]
