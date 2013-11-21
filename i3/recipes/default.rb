package 'i3'

if(node[:i3][:home])
  directory File.join(node[:i3][:home], '.i3') do
    action :create
    mode 0755
    owner node[:i3][:user]
    group node[:i3][:group] || node[:i3][:user]
  end

  display_items = {}
  node[:i3][:config][:order].each do |key|
    if(key.to_sym == :battery)
      display_items.merge!(
        "battery #{node[:i3][:battery_int]}" => {
          :format => '%status %percentage %remaning %emptytime',
          :path => '/sys/class/power_supply/BAT%d/uevent'
        }
      )
    else
      display_items.merge!(node[:i3][:config][:display_items][key])
    end
  end

  template File.join(node[:i3][:home], '.i3', 'i3status.conf') do
    source 'i3status.conf.erb'
    mode 0644
    owner node[:i3][:user]
    group node[:i3][:group] || node[:i3][:user]
    variables(
      :general => node[:i3][:config][:general],
      :items => display_items
    )
  end

  # TODO: Break this down into attributes
  template File.join(node[:i3][:home], '.i3', 'config') do
    source 'config.erb'
    mode 0644
    owner node[:i3][:user]
    group node[:i3][:group] || node[:i3][:user]
    variables(
      :dzen => node[:i3][:config][:general][:output_format] == 'dzen2'
    )
  end
else
  Chef::Log.warn "No i3 user home directory found. No configurations installed!"
end
