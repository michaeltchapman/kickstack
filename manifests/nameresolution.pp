# Simple convenience class for name resolution.
#
# Exports the current host's name, along with the IP address
# associated with the management NIC.
#
# Currently supports only entries in /etc/hosts. Alternative
# implementations might dynamically manage DNS entries.
class kickstack::nameresolution inherits kickstack {

  case $::kickstack::name_resolution {
    'hosts': {
      @@host { $hostname:
        ip => getvar("ipaddress_${::kickstack::nic_management}"),
        comment => 'Managed by Puppet',
        tag => 'hostname'
      }
      Host <<| tag == 'hostname' |>> {  }
    }
    default: {
      fail("Unsupported value for \$kickstack::name_resolution: $::kickstack::name_resolution")
    }
  }
}

