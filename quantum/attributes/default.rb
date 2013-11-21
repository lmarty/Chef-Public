default["developer_mode"] = false  # we want secure passwords by default

default["openstack"]["quantum"]["services"]["api"]["scheme"] = "http"
default["openstack"]["quantum"]["services"]["api"]["network"] = "public"
default["openstack"]["quantum"]["services"]["api"]["port"] = 9696
default["openstack"]["quantum"]["services"]["api"]["path"] = "/v2.0"

default["quantum"]["services"]["api"]["scheme"] = "http"
default["quantum"]["services"]["api"]["network"] = "public"
default["quantum"]["services"]["api"]["port"] = 9696
default["quantum"]["services"]["api"]["path"] = "/v2.0"

default["openstack"]["quantum"]["db"]["name"] = "quantum"
default["openstack"]["quantum"]["db"]["username"] = "quantum"

# TODO: These may need to be glance-registry specific.. and looked up by glance-api
default["openstack"]["quantum"]["service_tenant_name"] = "service"
default["openstack"]["quantum"]["service_user"] = "quantum"
default["openstack"]["quantum"]["service_role"] = "admin"

# logging attributes
default["openstack"]["quantum"]["syslog"]["use"] = false
default["openstack"]["quantum"]["syslog"]["facility"] = "LOG_LOCAL2"

# Network Plugins
default["openstack"]["quantum"]["plugin"] = "nicira" # nicira is the only presently working plugin

# Nicira NVP plugin settings
# uuid of the default NVP transport zone (must be created in NVP before starting quantum with the nvp plugin)
default["quantum"]["plugin"]["nvp"]["tz_uuid"] = "b0eeec88-5f36-4c23-a20e-62fe69d4c16b"
