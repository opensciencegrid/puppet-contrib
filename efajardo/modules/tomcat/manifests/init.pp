# Instantiates the puppet class, see puppet::tomcat
# Written by Edgar Fajardo (efajardo@physics.ucsd.edu)
# For the OSG Software team
class tomcat {
  class {'tomcat::puppet':
    package_instalation => "latest",
    }
 }
