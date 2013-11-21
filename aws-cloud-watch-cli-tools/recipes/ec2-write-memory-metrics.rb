#
# Cookbook Name:: aws-cloud-watch-cli-tools
# Recipe:: ec2-write-memory-metrics 
#
# Copyright (C) 2012 Applicaster LTD
# Authors:
#       Vitaly Gorodetsky <technical@applicaster.com>
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

return unless node[:cloud] && node[:cloud][:provider] == "ec2"

template "/usr/local/bin/ec2-write-memory-metrics.sh" do
  source "ec2-write-memory-metrics.sh"
  owner "ubuntu"
  group "ubuntu"
  mode 00755
end

file "/etc/cron.d/ec2-write-memory-metrics" do
  content <<-EOS
  # Update AWS custom metric monitors every minute
  */1 * * * * ubuntu /usr/local/bin/ec2-write-memory-metrics.sh
  EOS
end


