#gums/manifests/mysql.pp
# mysql gums class
# Developed by Edgar Fajardo
# On behalf of OSG SOFTWARE

class gums::mysql{
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
    ensure   => 'present',
    provider => 'yum',
    name     =>  "mysql.x86_64",
  }
             
}
  
