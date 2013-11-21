# The host portion of the externally-visible URL (e.g. service-broker.vcap.me).
default['cloudfoundry_service_broker']['host'] = "service-broker"

# Unique instance index.
default['cloudfoundry_service_broker']['index'] = 0

# Log level for the service_broker service.
default['cloudfoundry_service_broker']['log_level'] = "info"
