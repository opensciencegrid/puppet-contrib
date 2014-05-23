# == Class: rsv::service
#
# This module manages the basic rsv services
#
# === Parameters
#
class rsv::service {
  service { 'rsv':
    ensure => running,
    name   => "rsv",
    enable => true
  }

  service { 'condor-cron':
    ensure => running,
    name   => "condor-cron",
    enable => true
  }
  
}
