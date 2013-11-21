include_recipe 'yum::epel' if platform? %w{redhat centos}

package 'siege'
