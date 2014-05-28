#gums/manifests/tomcat.pp
#==Class==
# gums::tomcat
#
# Designed to manage the gums tomcat installation and running.
#=============
#
# Written by Edgar Fajardo (efajardo@physics.ucsd.edu)
# For the OSG Software team
# [*package_ensure*]
# Specifies if a package is wanted installed or latest. Only this two vaules are allowed.
#
#
class gums::tomcat (
  $package_ensure = 'installed',
)
{
  if $operatingsystemrelease=~ /5.*/ {
    $slversion="5"
  }
  elsif $operatingsystemrelease=~ /6.*/ {
    $slversion="6"
  }
  $tomcat = "tomcat${slversion}"
  package { "${tomcat}":
    ensure   => "${package_ensure}",
    name     =>  "${tomcat}",
    provider => 'yum'
  }
  service { 'tomcat':
    ensure => running,
    name   => "${tomcat}",
    enable => true
  }
  Package["${tomcat}"] -> Service['tomcat']
  user { 'tomcat_user':
    ensure => present,
    name   => "tomcat",
    uid    => 91,
  }
  # Ensure the certificates are in place and with the correct permissions
  file { 'httpcert':
    ensure => present,
    path   => '/etc/grid-security/http/httpcert.pem',
    owner  => tomcat,
    mode   => 444
  }

  file { 'httpkey':
    ensure => present,
    path   => '/etc/grid-security/http/httpkey.pem',
    owner  => tomcat,
    mode   => 400,
  }
  
  file{ 'server.xml':
    ensure => present,
    path   => "/etc/${tomcat}/server.xml",
  }
  # If any of the certificates or the configuration
  # changes to restart the tomcat service.
  File['httpcert'] ~> Service['tomcat']
  File['httpkey'] ~> Service['tomcat']
  File['server.xml'] ~> Service['tomcat']
  
}
