include_recipe 'python'

package 'git'

python_virtualenv node[:aminator][:root] do
  action :create
end

python_pip node[:aminator][:package] do
  package_name 'aminator'
  virtualenv node[:aminator][:root]
  action :install
end

