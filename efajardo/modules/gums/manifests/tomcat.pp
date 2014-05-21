# Instantiates the puppet class, see puppet::tomcat
# Written by Edgar Fajardo (efajardo@physics.ucsd.edu)
# For the OSG Software team
class gums::tomcat {
  class {'gums::tomcat_basic':
    package_instalation => "latest",
  }
}
