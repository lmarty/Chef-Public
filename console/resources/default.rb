actions :run
default_action :run

attribute :command, name_attribute: true, kind_of: String, required: true
attribute :cwd, kind_of: String
attribute :creates, kind_of: String
attribute :environment, kind_of: Array
attribute :timeout, kind_of: Fixnum, default: 300
attribute :returns, kind_of: Fixnum, default: 0
attribute :interrupts, kind_of: Hash
attribute :answers, kind_of: Hash
attribute :user, kind_of: String
