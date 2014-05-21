#gums/manifests/init.pp
# Develoved by Edgar Fajardo on behalf
#  OSG SOFTWARE TEAM
#
class gums ($osg_release = "3.2") {
  # Necessary modules 
  class {'osg_release': osgver => "${osg_release}" }
  class {'osg_certs': }
  class {'fetch-crl': }
  # The gums submodules
  class {'gums::mysql': }
  class {'gums::tomcat': }
  
  # The gums package itself
  package {'osg-gums':
    ensure   => "installed",
    name     =>  "osg-gums",
    provider => 'yum',
  }

  file { 'gums.config':
    ensure => present,
    path   => '/etc/gums/gums.config',
    owner  => tomcat,
    mode   => 600,
    source => 'puppet:///modules/gums/gums.config'
  }
 
 
}


