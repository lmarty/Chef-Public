# encoding: utf-8
default[:i3][:home] = nil
default[:i3][:config][:general] = {
  :output_format => 'none',
  :colors => false,
  :interval => 1,
  :color_good => "#00FF00",
  :color_degraded => "#0000FF",
  :color_bad => "#FF0000",
  :color_separator => "#b096b7"
}
default[:i3][:config][:order] = [
  :network,
  :run_watches,
  :battery,
  :basics
]
default[:i3][:battery_int] = 0
default[:i3][:config][:display_items] = {
  :network => {
    'wireless wlan0' => {
      :format_up => 'W: (%quality at %essid, %bitrate) %ip',
      :format_down => 'W: down'
    },
    'ethernet eth0' => {
      :format_up => 'E: %ip (%speed)',
      :format_down => 'E: down'
    }
  },
  :run_watches => {
    'run_watch VPN' => {
      :pidfile => '/var/run/vpnc/pid'
    }
  },
  :basics => {
    :load => {
      :format => '%5min'
    },
    'disk /' => {
      :format => '%free free'
    },
    :time => {
      :format => '%Y-%m-%d %H:%M:%S'
    }
  }
}

