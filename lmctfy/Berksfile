site :opscode

metadata

cookbook "control_groups", github: "hw-cookbooks/control_groups"
cookbook "gflags", github: "bflad/chef-gflags"
cookbook "protobuf", github: "bflad/chef-protobuf"
cookbook "re2", github: "bflad/chef-re2"

group :integration do
  cookbook "minitest-handler"
  cookbook "lmctfy_test", path: "test/cookbooks/lmctfy_test"
end
