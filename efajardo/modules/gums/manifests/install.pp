# gums/manifests/install.pp
# == Class: gums::install ===========================
#
# This module manages gums installation and auxilary software
# components needed: mysql, tomcat
# ===========================================
# Developed by Edgar Fajardo
# on behalf of OSG Software
# == Architecture ======================
# gums::mysql running mysql and making sure user and certs are present
# gums::tomcat making sure tomcat is running and cert files are in place
#
# === Parameters =========================
#
# [*osg_version*]
# Specifies the osg_version under to install the repos (3.1 or 3.2)
#
# [*package_ensure*]
# Specifies if a package is wanted installed or latest. Only this two vaules are allowed.
#
#
class gums::install (
  $osg_release    = "3.2",
  $package_ensure = "installed",
  )
{
  # Necessary modules
  class {'osg_release':
    osgver => "${osg_release}"
  }
  class {'osg_certs': }
  class {'fetch-crl': }
  # The gums submodules
  class {'gums::mysql':
    package_ensure => $package_ensure,
  }
  class {'gums::tomcat':
    package_ensure => $package_ensure,
  }
  # The gums package itself
  package {'osg-gums':
    ensure   => "${package_ensure}",
    name     => "osg-gums",
    provider => 'yum',
  }
  Class['osg_release'] -> Class['osg_certs']
  Class['osg_certs']   -> Class['fetch-crl']
  Class['fetch-crl']   -> Package['osg-gums']
  Package['osg-gums']  -> Class['gums::mysql']
  Class['gums::mysql'] -> Class['gums::tomcat']
 
}
