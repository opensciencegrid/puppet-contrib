#
# Class rsv::apache
# 
# Developed by Edgar Fajardo
# on behalf OSG OSG SOFTWARE

class rsv::apache {

  service{ 'apache':
    ensure    => running,
    name      => 'httpd',
    subscribe => File['httpd.conf']
  }

  package{ 'apache':
    ensure   => installed,
    name     => 'httpd.x86_64',
    provider => yum,
  }

  file { 'httpd.conf':
    ensure => present,
    path   => '/etc/httpd/conf/httpd.conf',
  }

  Package['apache'] -> Service['apache']
}
