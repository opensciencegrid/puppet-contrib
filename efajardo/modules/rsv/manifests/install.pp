#rsv/manifests/install.pp
# Class for rsv install
# Developed by Edgar Fajardo
# On behalf OSG of SOFTWARE
# === Parameters
#
# === Parameters
#
# [*osg_version*]
#   Specifies the osg_version under to install the repos (3.1 or 3.2)
#
#
class rsv::install (
  $osg_version = '3.2',
)
{
  # The necessary modules that are needed for the rsv installation
  class {'osg_release':
    osgver => "${osg_version}"
  }
  class { 'osg_certs': }
  class { 'rsv::apache': }
  class { 'fetch-crl': }
  # The actual package to be installed
  package { 'rsv':
    ensure   => "installed",
    name     =>  "rsv",
    provider => 'yum',
  }

  # The necessary cert files needed
  file { 'rsvcert':
        ensure => present,
        path   => '/etc/grid-security/rsv/rsvcert.pem',
        owner  => rsv,
        mode   => 444
  }
  file { 'rsvkey':
        ensure => present,
        path   => '/etc/grid-security/rsv/rsvkey.pem',
        owner  => rsv,
        mode   => 400
  }

  # The users needed for the package
  user { 'rsv':
    ensure => present,
    name   => "rsv",
  }

  user { 'cndrcron':
    ensure => present,
    name   => "cndrcron",
  }

  # Ensure the package is installed before creating the users
  # since the package creates the users
  Package['rsv'] -> User['rsv']
  Package['rsv'] -> User['cndrcron']
  
    
}
    
