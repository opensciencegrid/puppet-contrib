#gums/manifests/init.pp
# == Class: gums
#
# This module manages gums
# Developed by Edgar Fajardo
# on behalf of OSG Software
#
# == Architecture
# It is made out of two parts:
# gums::install for installation and cert files
# gums::config for the actual configuration
# === Parameters
#
# [*osg_version*]
#   Specifies the osg_version under to install the repos (3.1 or 3.2)
#
# [*package_ensure*]
# Specifies if a package is wanted installed or latest. Only this two vaules are allowed.
#
#
class gums (
  $osg_release    = "3.2",
  $package_ensure = "installed",
)
{
  class{ 'gums::install':
    osg_release    => $osg_release,
    package_ensure => $package_ensure,
  }
  class{ 'gums::config': }
  Class['gums::install'] -> Class['gums::config']
 
 
}


