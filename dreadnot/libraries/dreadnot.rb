# encoding: utf-8

def instance_dir(new_resource_name)
  "#{node['dreadnot']['instance_prefix']}/#{new_resource_name}"
end

def ensure_http_port(name, port)
  return port if port
  8080 + name.scan(/./).map(&:ord).reduce(:+)
end
