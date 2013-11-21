# encoding: utf-8

actions :create, :remove

attribute :instance_name, kind_of: String, name_attribute: true,
  regex: /^[-a-z_]+$/
attribute :git_repository, kind_of: [String, NilClass], default: nil
attribute :git_revision, kind_of: [String, NilClass], default: nil
attribute :http_port, kind_of: [String, Integer], default: nil

default_action :create
