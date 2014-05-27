#gums/manifests/mysql.pp
#==Class==
# gums::mysql
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
class gums::mysql (
    $package_ensure = 'installed',
)
{
  service { 'mysql':
    ensure => running,
    name   => "mysqld",
    enable => true,
  }

  user { 'mysql':
    ensure => 'present',
    uid    => '27'
  }

  package{ 'mysql':
    ensure   => $package_ensure,
    provider => 'yum',
    name     => "mysql.x86_64",
  }
             
}
  
