#gums/manifests/config.pp
# == Class: gums::config ===========================
#
# This module manages gums file configuration
# ===========================================
# Developed by Edgar Fajardo
# on behalf of OSG Software
# == Architecture ======================
#
# === Parameters =========================
#
#
#

class gums::config
{
  file { 'gums.config':
    ensure => present,
    path   => '/etc/gums/gums.config',
    owner  => tomcat,
    mode   => 600,
    #source => 'puppet:///modules/gums/gums.config'
  }

}
